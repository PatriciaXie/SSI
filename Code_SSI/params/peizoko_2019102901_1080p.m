%% 视频参数
videoName = 'peizoko_2019102901_1080p.avi'; % 视频名
t0  = 106; % 装置稳定的开始时间（秒）
gx = [788;372;1197]; % 三角形区域的顶点x坐标
gy = [150;966;966];  % 三角形区域的顶点y坐标

% 路径
videoPath = ['../Data_SSI/', videoName];
positionPath = ['result/', videoName(1:end-4), '/position.mat'];
ssiPath = ['result/', videoName(1:end-4), '/ssi.mat'];

%% 检测参数
kernelW = 4; % 果蝇的宽度（像素）
kernelH = 13; % 果蝇的高度（像素）
nAngle = 12;  % 要划分的身体朝向数 
kernelSize = 5; % 平滑原始图像的高斯核边长
theta1 = 0.7;      %归一化图像的阈值
theta2 = 0.5;      % 果蝇中心的最小归一化像素值

%% SSI 参数
n_real = 41; % 果蝇数目
bin = 17.3; % 0.5cm在图像上的像素数，如0.5cm = 17.3像素
filterR = 1000; % 平滑高斯滤波的半径