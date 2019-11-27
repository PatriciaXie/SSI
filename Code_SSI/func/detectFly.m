function [flyCenters, flyOrientations, flyProbabilities] = detectFly(img, gaussKernals, kernelSize, theta)
    
    % 确定有目标的位置，但是基本不能处理重叠的情况
    [groups, n0] = findFlyGroup(img, kernelSize, theta);
    for i = 1:1:n0
%         fprintf('Process group %d, ', i);
        map = groups{i}.map;
        patch = groups{i}.img;
        
        [groups{i}.flyCs, groups{i}.flyOs, groups{i}.flyPs, groups{i}.n] = analyseGroup(groups{i}.no, patch, map, gaussKernals);
%         fprintf(' %d flies found.\n', groups{i}.n);
        % 画图验证1
%         figure(2), clf, set(gca, 'Position', [0,0,1,1]); imshow(map);
%         figure(3), clf, set(gca, 'Position', [0,0,1,1]); imshow(patch);
%         hold on
%         plot(groups{i}.flyCs(:, 2), groups{i}.flyCs(:, 1), 'r+', 'LineWidth', 3);
%         for k = 1:1:groups{i}.n
%             plot(ellipse{groups{i}.flyOs(k)}(1,:)+groups{i}.flyCs(k, 2), ellipse{groups{i}.flyOs(k)}(2,:)+groups{i}.flyCs(k, 1), 'r-', 'LineWidth', 3);
%         end
%         hold off
        
    end
    k = 1;
    for i = 1:1:n0
        for j = 1:1:groups{i}.n
            flyCenters(k, :) = groups{i}.flyCs(j, :) + [groups{i}.roi(2), groups{i}.roi(1)] - 1;
            flyOrientations(k,1) = groups{i}.flyOs(j);
            flyProbabilities(k,1) = groups{i}.flyPs(j);
            
            k = k + 1;
        end
    end
    
    
end
    
function [groups, k] = findFlyGroup(img, kernelSize, theta)
    k = 0;
    f = createGauss(kernelSize,kernelSize);
    img = imgNormalize( conv2(img, f, 'same') );
    mask = imbinarize(img, theta); 
%     imshow([img, mask]); colormap('jet');
    [map, n] = bwlabel(mask, 8);
    groups = cell(1, 1); %group = struct{'img', [], 'flyCs', [], 'flyOs', [], 'C', []};
    for i = 1:1:n
        [r,c] = find(map==i);
        if length(r)<2
            continue;
        else
            k =  k + 1;
        end
        x0 = min(c); x1 = max(c); dx = x1-x0+1;
        y0 = min(r); y1 = max(r); dy = y1-y0+1;

        dd = round( max(6, max(dx, dy)) );
        roi = [x0-dd, y0-dd, 3*dd, 3*dd];
        [patch, real_roi] = getImageROI(img, roi);
        [map_patch, ~] = getImageROI(map, roi);
        xc = round(mean(c)) - real_roi(1) + 1;
        yc = round(mean(r)) - real_roi(2) + 1;

        group.img = patch;
        group.map = map_patch;
        group.no = i;
        group.roi = real_roi;
        group.flyCs = [];
        group.flyOs = [];
        group.C = [yc, xc];
        groups{k,1} = group;
    end
end