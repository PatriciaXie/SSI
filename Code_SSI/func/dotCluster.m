function [p2, n2] = dotCluster(p1, sigma2)
    n1 = size(p1, 1);
    p2 = p1;
    n2 = n1;
    go = 1;
    while n2 > 1 &&  go == 1
        c = 1; go = 0;
        while c < n2
            dp1 = p2(c, 1) - p2(c+1:end, 1);
            dp2 = p2(c, 2) - p2(c+1:end, 2);
            d = dp1.^2 + dp2.^2;
            neighbor_id = find(d < sigma2);
            if isempty(neighbor_id)
                c = c + 1;
            else
                neighbor = p2(neighbor_id+c, :);
                p2(neighbor_id+c, :) = [];
                n2 = n2 - length(neighbor_id);
                p2(c, :) = (sum(neighbor, 1)+ p2(c, :))/(1+length(neighbor_id));
                go = 1;
            end
        end
    end
    p2 = round(p2);
end