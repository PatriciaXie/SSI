function flyCenters = detectFlySimple(img, theta)
    mask = imbinarize(img, theta); 
    mask_gpu = gpuArray(mask);
    [map, n] = bwlabel(mask_gpu, 4);
    flyCenters = zeros(n, 2);
    for i = 1:1:n
        [r,c] = find(map==i);
        r = mean(r);
        c = mean(c);
        flyCenters(i, :) = gather([r, c]);
    end
end