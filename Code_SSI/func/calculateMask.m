function [mask, roi] = calculateMask(gx, gy)

%     accept = 0;
    % gx = [797.7;404.7;1232.7]; gy = [56.7;929.7;941.7];
%     while accept == 0 && ~exist('gx', 'var') && ~exist('gy', 'var')
%         figure(1), clf
%         imshow(frame);
%         hold on
%         disp('Click triangle vertices\n');
%         gx = zeros(3, 1);
%         gy = zeros(3, 1);
%         for k = 1:1:3
%             [gx(k), gy(k)] = ginput(1);
%             plot(gx(k), gy(k), 'r+');
%         end
%         plot([gx; gx(1)], [gy; gy(1)], 'r-');
%         hold off
%         accept = input('Accept([1] or [0]): ');
%     end

    xLeft = floor( min(gx) );
    xRight = ceil( max(gx) );
    yTop = floor( min(gy) );
    yBottom= ceil( max(gy) );
    h = yBottom-yTop+1;
    w = xRight-xLeft+1;
    gx = gx-xLeft+1;
    gy = gy-yTop+1;
    A = [gx(1), gy(1)];
    B = [gx(2), gy(2)];
    C = [gx(3), gy(3)];
    mask = ones(h, w);
    for x = 1:1:w
        for y = 1:1:h
            PA = A - [x, y];
            PB = B - [x, y];
            PC = C - [x, y];
            APB = acos(dot(PA, PB) / norm(PA) / norm(PB));
            APC = acos(dot(PA, PC) / norm(PA) / norm(PC));
            BPC = acos(dot(PB, PC) / norm(PB) / norm(PC));

            if APB+APC+BPC < 2*pi - 1e-5
                mask(y, x) = 0;
            end
        end
    end
    roi = [xLeft, yTop, xRight-xLeft+1, yBottom-yTop+1];
end