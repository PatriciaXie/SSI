%% ��Ƶ����
videoName = 'peizoko_2019102901_1080p.avi'; % ��Ƶ��
t0  = 106; % װ���ȶ��Ŀ�ʼʱ�䣨�룩
gx = [788;372;1197]; % ����������Ķ���x����
gy = [150;966;966];  % ����������Ķ���y����

% ·��
videoPath = ['../Data_SSI/', videoName];
positionPath = ['result/', videoName(1:end-4), '/position.mat'];
ssiPath = ['result/', videoName(1:end-4), '/ssi.mat'];

%% ������
kernelW = 4; % ��Ӭ�Ŀ�ȣ����أ�
kernelH = 13; % ��Ӭ�ĸ߶ȣ����أ�
nAngle = 12;  % Ҫ���ֵ����峯���� 
kernelSize = 5; % ƽ��ԭʼͼ��ĸ�˹�˱߳�
theta1 = 0.7;      %��һ��ͼ�����ֵ
theta2 = 0.5;      % ��Ӭ���ĵ���С��һ������ֵ

%% SSI ����
n_real = 41; % ��Ӭ��Ŀ
bin = 17.3; % 0.5cm��ͼ���ϵ�����������0.5cm = 17.3����
filterR = 1000; % ƽ����˹�˲��İ뾶