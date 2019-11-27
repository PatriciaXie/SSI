%% Video Parameters
videoName = 'peizoko_2019102901_1080p.avi'; % Video Name
t0  = 106; % the time when the device gets stable (second)
gx = [788;372;1197]; % triangle x-coordinate
gy = [150;966;966];  % triangle y-coordinate

% Path
videoPath = ['../Data_SSI/', videoName];
positionPath = ['result/', videoName(1:end-4), '/position.mat'];
ssiPath = ['result/', videoName(1:end-4), '/ssi.mat'];
mkdir(['result/' , videoName(1:end-4)]);
%% Detection Parameters
kernelW = 4;        % width of flies (pixel)
kernelH = 13;       % height of flies (pixel)
nAngle = 12;        % count of orientations
kernelSize = 5;     % gauss kernal size to smooth the original images
theta1 = 0.7;      % normalized threshold
theta2 = 0.5;      % minimum gray intensity of target (after normalization)

%% SSI Parameters
n_real = 41;        % count of flies
bin = 17.3;         % 0.5 cm means 'bin' pixel on image
filterR = 1000;     % gauss kernal size to smooth SSI