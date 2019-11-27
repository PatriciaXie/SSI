function [flyCs, flyOs, flyPs, n] = analyseGroup(no, patch, map, gaussKernals)
    [keyResp, centers, ~] = getResponse(no, patch, map, gaussKernals);
    n = size(keyResp, 1);
    flyCs = zeros(n, 2);
    flyOs = zeros(n, 1);
    flyPs = zeros(n, 1);
    for i = 1:1:n
        flyCs(i, :) = centers(i, :);
        [flyOs(i),flyPs(i)] = findPeak(keyResp(i, :));
    end
end

function [keyResp, centers, response] = getResponse(no, patch, map, gaussKernals)
    nAngle = length(gaussKernals);
    response = zeros(nAngle, size(patch, 1), size(patch, 2));
    centers = [];
    parfor j =  1:1:nAngle
        f = gaussKernals{j};
        tmp = conv2(patch, f, 'same');
%         tmp=ifft2(fft2(patch).*f);
        response(j, :, :) = reshape(tmp, [1, size(patch, 1), size(patch, 2)]);
        [tmp2, ~, ~] = centerGradient(tmp, no, map);
        centers = [centers; tmp2];
    end
    [centers, n] = dotCluster(centers, 11);
    maxR = max(response(:));
    minR = min(response(:));
    response = (response - minR)/ (maxR - minR);
    keyResp = zeros(n, nAngle);
%     figure(1), clf
%     hold on
    for i = 1:1:n
        for j = 1:1:nAngle
            keyResp(i, j) = response(j, centers(i, 1), centers(i, 2));
        end
%         plot(keyResp(i, :), 'o-' );
    end
%     hold off
end
function [xPeak, yPeak] = findPeak(y)
    y1 = [y(end), y, y(1)];
    [~, xPeak] = findpeaks(y1);
    xPeak = xPeak - 1;
    for i = 1:1:length(xPeak)
        if xPeak(i) <= 0 || xPeak(i) > length(y)
            xPeak(i) = 0;
        end
    end
    xPeak = xPeak(xPeak > 0);
    
    if length(xPeak) > 1
        % 获得最显著的一个
         xPeak = find(y == max(y));
         
    else
        if  isempty(xPeak)
            a = 1;
            xPeak = find(y == max(y));
        end
    end
    yPeak = y(xPeak);
end