function [kernel, ellipse, kernel_f] = generateGaussKernel(width, height, nAngle)
    kernal0 =zeros(2*height+1, 2*height+1);
    w0 = height - width + 1; 
    w1 = w0 + 2*width;
    kernal0(:, w0:w1) = createGauss(2*height+1, 2*width+1);
    ellipse0 = zeros(2, 36);
    for i = 1:1:37
        theta = (i-1)*pi/18;
        x = width*cos(theta)/2;
        y = height*sin(theta)/2;
        ellipse0(:, i)  = [x; y];
    end
    
    angles = (linspace(1, nAngle, nAngle)'-1) * pi/nAngle;
    kernel = cell(nAngle, 1);
    kernel_f = cell(nAngle, 1);
    ellipse = cell(nAngle, 1);
    for i = 1:1:nAngle
        tmp = imrotate(kernal0, rad2deg(angles(i)), 'bilinear'); 
        dLen = size(tmp, 1) - 2*height - 1;
        if mod(dLen, 2) == 0
            kernel{i} = tmp(dLen/2+1:end-dLen/2, dLen/2+1:end-dLen/2);
            kernel_f{i} = fft2(kernel{i});
        else
            tmp = imresize(tmp, 2);
            tmp = tmp(dLen+1:end-dLen, dLen+1:end-dLen);
            kernel{i} = imresize(tmp, 0.5);
            kernel_f{i} = fft2(kernel{i});
        end
%         if exist('kernel', 'file')
%             name = sprintf('kernel/%02d.bmp', i);
%             imwrite(kernel{i}, name);
%         end
            
        % Õ÷‘≤◊¯±Í
        R = [cos(-angles(i)), -sin(-angles(i)); sin(-angles(i)), cos(-angles(i))];
        ellipse{i} = R*ellipse0;
        
        % ≤‚ ‘
%         figure(1), clf, set(gca, 'Position', [0,0,1,1]); imshow(kernel{i});
%         hold on
%         plot(ellipse{i}(1,:)+height+1, ellipse{i}(2,:)+height+1, 'ro-');
%         hold off
    end
end