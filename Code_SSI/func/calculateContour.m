function contour = calculateContour(xc, yc, img, n)
    % 认为图像中只有一个果蝇
    contour = zeros(n, 2);
    [h, w] = size(img);
    rho = round(min([xc, w-xc, yc, h-yc])-1);
    ds = linspace(0, rho, rho+1)';
    
    %直线方程, y = k(x-x0)+y0
%     figure(1), set(gca, 'Position', [0,0,1,1]), imshow(img);
    
    for i  = 1:1:n
        beta = (i-1)*2*pi/n;
        xs = xc+ds*cos(beta);
        ys = yc+ds*sin(beta);
        
        ps = bilinearInterp(xs, ys, img); % 减函数ps0 = bilinearInterp(xs, ys, img); % 减函数
        ps_y = ps;
        for j = 1:1:length(ps)
            if ps(j) < 0.15
                ps_y = ps(1:j);
                break;
            end
        end
        
        n_ps = length(ps_y);
        ps_x = linspace(0, n_ps-1, n_ps)';
        c = 0.25;
        if ps_y(end) > c
            x0 = ps_x(end); y0 = ps_y(end);
            x1 = x0+1;
            d = x1 - c/y0;
        else
            f = fit(ps_x, ps_y, 'Poly1');
            d = (c - f.p2) / f.p1;
        end
%         figure(1)
%         hold on
%         plot(ys,  xs, 'ro-');
%         plot(yc+d*sin(beta), xc+d*cos(beta), 'b*');
%         hold off
%         figure(2), plot(f, ps_x, ps_y);
        x = xc + d*cos(beta);
        y = yc + d*sin(beta);
        contour(i, 1) = x;
        contour(i, 2) = y;
    end
end
function ps = bilinearInterp(xs, ys, img)
    nn = length(xs);
    ps = zeros(nn, 1);
    for k=1:1:nn
        x = xs(k); y = ys(k);
        x0 = floor(x); x1 = ceil(x); dx = x-x0;
        y0 = floor(y); y1 = ceil(y); dy = y-y0;
        p0 = img(x0, y0)*dx + img(x0, y1)*(1-dx);
        p1 = img(x1, y0)*dx + img(x1, y1)*(1-dx);
        ps(k) = p0*dy + p1*(1-dy);
    end
end