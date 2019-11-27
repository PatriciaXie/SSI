[mask, roi] = calculateMask(gx, gy);
[gaussKernels, ellipse, gaussKernels_f] = generateGaussKernel(kernelW, kernelH, nAngle);

v = VideoReader(videoPath);
v.CurrentTime = t0;
T = 1;

% Detect
while hasFrame(v)
    frame = readFrame(v);
    frame = double( rgb2gray( frame(roi(2):roi(2)+roi(4)-1, roi(1):roi(1)+roi(3)-1, :)) )/255;
    fprintf('Process image %d - %d\n ', v.CurrentTime, v.Duration);
    
    % normalize image
    img = preProcess(frame, mask, theta1); 

    % detect flies' position and orientation
    [flyCenters, flyOrientations, flyProbabilities] = detectFly(img, gaussKernels, kernelSize, theta2);
    position{t, 1} = flyCenters;
    position{t, 2} = flyOrientations;
    position{t, 3} = flyProbabilities;
    T = T + 1;
%     figure(1), clf, imshow(img);
%     hold on
%     plot(flyCenters(:, 2), flyCenters(:, 1), 'go', 'LineWidth', 1);
%     hold off
end
save(positionPath, 'position', 'ellipse', 'T', 'mask', 'roi');

