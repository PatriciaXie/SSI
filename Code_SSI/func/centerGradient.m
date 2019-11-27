function [centers, n1, response4] = centerGradient(response, no, map0)
    [h, w] = size(response);
    response2 = zeros(h+2, w+2);
    response2(1,1) = response(1,1);
    response2(1,end) = response(1,end);
    response2(end,1) = response(end,1);
    response2(end,end) = response(end,end);
    response2(1,2:end-1) = response(1,:);
    response2(end,2:end-1) = response(end,:);
    response2(2:end-1,1) = response(:,1);
    response2(2:end-1,end) = response(:,end);
    response2(2:end-1,2:end-1) = response;
    response3 = zeros(h, w);
    response4 = zeros(h, w);
    for x = 1:1:w
        for y = 1:1:h
            p = response(y, x);
            p2 = response2(y:y+2, x:x+2);
            tmp = sign( p - p2 );
            tmp(tmp==0)=1;
            tmp(2,2) = 0;
            if sum(tmp(:))== 8% || sum([tmp(1,2),  tmp(2,1), tmp(2,3), tmp(3,2)]) == 4 || sum([tmp(1,1),  tmp(1,3), tmp(3,1), tmp(3,3)]) == 4
                response3(y, x) = 1;
            end
        end
    end
    
    % 连通的记为一个
    [map, n] = bwlabel(response3, 8);
    centers = zeros(n, 2);
    for i = 1:1:n
        [r,c] = find(map==i);
        r = round(mean(r));
        c = round(mean(c));
        centers(i, 1) = r;
        centers(i, 2) = c;
    end
    
    % 中心值显著低的去掉（噪点）
    maxResponse = max(response(:));
    n1 = n;
    for i = 1:1:n
        if response(centers(i, 1), centers(i, 2)) < 0.8*maxResponse || map0(centers(i, 1), centers(i, 2)) ~= no
            centers(i, :) = [0, 0];
            n1 = n1 - 1;
        end
    end
    centers = reshape(centers(centers ~= 0), [n1, 2]);
    
    % 距离小于sqrt(6)的算一个
    [centers, n1] = dotCluster(centers, 4);

    for i = 1:1:n1
        r = centers(i, 1);
        c = centers(i, 2);
        response4(r, c) = 1;
    end
end