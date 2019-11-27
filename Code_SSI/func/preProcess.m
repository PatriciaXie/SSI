function img = preProcess(img, mask, theta)
    img(mask==0) = theta;
    img = imgNormalize(1-img);
end