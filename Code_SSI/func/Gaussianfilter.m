function y_filted = Gaussianfilter(r, sigma, y)

% 生成一维高斯滤波模板
GaussTemp = ones(1,r*2-1);
for i=1 : r*2-1
    GaussTemp(i) = exp(-(i-r)^2/(2*sigma^2))/(sigma*sqrt(2*pi));
end

% 高斯滤波
y_filted = y;
for i = r : length(y)-r+1
    y_filted(i) = y(i-r+1 : i+r-1).*GaussTemp';
end