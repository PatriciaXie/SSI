[mask, roi] = calculateMask(gx, gy);
if ~exist('simplized', 'var') || simplized == 0
    [gaussKernels, ellipse, gaussKernels_f] = generateGaussKernel(kernelW, kernelH, nAngle);
end
v = VideoReader(videoPath);
v.CurrentTime = t0;
T = 1;
lenT = (v.Duration - v.CurrentTime + 1) * v.FrameRate;
% Detect
tic; te = 1;
while hasFrame(v)
    frame = readFrame(v);
    frame = double( rgb2gray( frame(roi(2):roi(2)+roi(4)-1, roi(1):roi(1)+roi(3)-1, :)) )/255;
    timeLeft = lenT * te / T;
    fprintf('%dm %ds used,  %dm %ds left\n', floor(te/60), floor( mod(te, 60)), floor(timeLeft/60), floor( mod(timeLeft, 60)));
    
    % normalize image
    img = preProcess(frame, mask, theta1); 

    % detect flies' position and orientation
    if ~exist('simplized', 'var') || simplized == 0
        [flyCenters, flyOrientations, flyProbabilities] = detectFly(img, gaussKernels, kernelSize, theta2);
        position{T, 1} = flyCenters; position{T, 2} = flyOrientations; position{T, 3} = flyProbabilities;
    else
        flyCenters = detectFlySimple(img, theta3);
        position{T, 1} = flyCenters;
    end
    T = T + 1;
%     figure(1), clf, imshow(img);
%     hold on
%     plot(flyCenters(:, 2), flyCenters(:, 1), 'go', 'LineWidth', 1);
%     hold off
    te = toc;
end
T = T - 1;
if ~exist('simplized', 'var') || simplized == 0
    save(positionPath, 'position', 'ellipse', 'T', 'mask', 'roi');
else
    save(positionPath, 'position', 'T', 'mask', 'roi');
end

