function flyCenters = detectFlySimple(img, theta)
    mask = imbinarize(img, theta); 
    [map, n] = bwlabel(mask, 4);
    flyCenters = zeros(n, 2);
    for i = 1:1:n
        [r,c] = find(map==i);
        r = mean(r);
        c = mean(c);
        flyCenters(i, :) = [r, c];
    end
end