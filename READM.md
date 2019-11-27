1. 将待处理的视频放在`Data_SSI`目录下。

2. 修改`Code_SSI/params`文件夹下的文件，以配置参数。包括

   - `videoName`，视频名
   - `t0`，装置稳定的开始时间（秒）
   - `gx`，三角形区域的顶点x坐标；`gy`，三角形区域的顶点y坐标
   - `n_real`，果蝇数目
   - `bin`，0.5cm在图像上的像素数，如0.5cm = 17.3像素，则填17.3

   其他参数可以不改。

3. 运行`STEP1_SetParameters.m`， 生效步骤2的设置。

4. 运行`STEP2_Detect.m`，对每一帧的果蝇进行检测，结果`position.m`保存到result文件夹中。

5. 运行`STEP3_SSI.m`，计算每一帧的SSI [1]。

6. 运行`STEP4_PlotSSI.m`，画出SSI随时间变化图。

[1] Simon, A. F. , Chou, M. T. , Salazar, E. D. , Nicholson, T. , Saini, N. , & Metchev, S. , et al. (2012). A simple assay to study social behavior in drosophila: measurement of social space within a group1. *Genes Brain & Behavior*, *11*(2), 243-252. 