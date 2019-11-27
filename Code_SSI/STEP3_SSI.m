load(positionPath);

nbins = 30;
xbins = linspace(0, nbins*bin, nbins+1);
values = zeros(T, nbins+1);
SSI = zeros(1, T);
for t = 1:1:T
    fprintf('Process image %d/%d\n', t, T);
    p = position{t,1};
    n = size(p, 1);
    dMatrix = zeros(n*(n-1), 1);
    % caculate mutual distance
    k = 1;
    for i = 1:1:n
        p1 = p(i, :);
        for j = i+1:1:n
            p2 = p(j, :);
            dMatrix(k) = norm(p1 - p2);
            k = k + 1;
        end
    end
    tmpV = hist(dMatrix, xbins);
    n_add = n - n_real;
    tmpV(1) = tmpV(1) - (n_add^2 + 2*n_add*n_real - n_add );
    values(t, :) = tmpV/n_real/(n_real-1);
    SSI(t) =values(t, 1) - values(t, 2);
end


sigma = filterR/3;
f = zeros(2*filterR-1, 1);
c = 1/sqrt(2*pi)/sigma;
for x = 1:1:2*filterR-1
    dx = (x - filterR)^2 / 2 / sigma^2;
    f(x) = c*exp(-dx);
end
tmpSSI = [fliplr(SSI(1:filterR)), SSI, fliplr(SSI(end-filterR:end))];
SSI2 = conv(tmpSSI, f, 'same');
SSI2 = SSI2(filterR+1:end-filterR-1);


save(ssiPath, 'SSI', 'SSI_f');