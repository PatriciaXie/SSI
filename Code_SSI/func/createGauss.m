function filter = createGauss(h, w)
sigma_h = h/6;
sigma_w = w/6;
filter = zeros(h, w);
% c = 1/(2*pi*sigma_h*sigma_w);

for x = 1:1:w
    dx = x-1 - (w-1)/2;
    a1 = dx^2/sigma_w^2;
    for y = 1:1:h
        dy = y-1-(h-1)/2;
        a2 = dy^2/sigma_h^2;
        filter(y, x) = exp(-0.5*(a1+a2));
%         filter(y, x) = c*exp(-0.5*(a1+a2));
    end
end
% figure; set(gca, 'Position', [0, 0, 1, 1]);imshow(filter);
end