function [imgROI, real_roi] = getImageROI(img, roi)
% x0, y0, w, h
    [H,W] = size(img);
    x0 = roi(1);
    y0 = roi(2);
    Dx = roi(3);
    Dy = roi(4);
    x0 = max(1, x0);
    x1 = min(W, x0+Dx-1);
    y0 = max(1, y0);
    y1 = min(H, y0+Dy-1);
    imgROI = img(y0:y1, x0:x1);
    real_roi = [x0, y0, x1-x0+1, y1-y0+1];
end