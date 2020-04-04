%Author:Wei
%Create date:2020/03/31
%Abstract:主函数
clc
clear
close all

% theta=zeros(13,2); % 各关节转角
theta=load('theta.txt');    %theta为13*2矩阵，每行为万向节的X,Y转角。额外的，最后一行指末端负载，一般为0即可
%CableTheta=zeros(12,3);
CableTheta(:,1)=load('CableTheta.txt'); %控制各节段的绳与X轴所成的角度
CableTheta(:,2)=CableTheta(:,1)+120;
CableTheta(:,3)=CableTheta(:,1)-120;
Pb=[0 200 200];  %底座坐标     问题出在Pb上
Pb_init=[0 200 0]; %初始状态时的底座坐标
linkl=143.5;
jointl=6.5;
linkr=30;
h=(2*jointl+linkl)*ones(1,13);   % h为各节段的长度。当前设置均为恒定值，后续可更改
% theta=[];  %本段注释部分功能为写入角度数据。需要输入角度时，可从此处输入
% [m, n] = size(theta);
% fid=fopen('C:\Users\sjjdw\Desktop\softmare\theta.txt','wt');
% for i = 1 : m
% 	fprintf(fid, '%g\t', theta(i, :));
% 	fprintf(fid, '\n');
% end
% fclose(fid);

[Keypoints,Trans,TransBase]=CalTransform(h,theta,Pb);   % 计算变换矩阵。Keypoints为关节点坐标，Trans为相邻坐标系变换阵，TransBase为各坐标系相对世界坐标系的变换阵
CableLength=CalCableLength(CableTheta,Trans,linkl,jointl); %根据各关节变换矩阵，计算各个绳长 
DrawImage(linkl,linkr,jointl,TransBase);  %绘制机器人当前图像
[Traj,k]=GenTraj(Keypoints,Pb_init); %根据关节点和基座的初始位置，插值生成离散的轨迹点。k为直线段上的点数，也即是基座从初始位置到最终位置运动的次数。
%k包含了直线段的最后一个点，但不包含起点。整个直线段实际上有k+1个点

% Keypoints_iter= Cal_Keypoints_iter(Traj,k_Pb,h); %根据离散的轨迹点，以及当前基座所在的轨迹点，计算当前所有关键点的位置
%                                                  %k_Pb为当前基座所在轨迹点，h为各段的长度

% Keypoints_iter= Cal_Keypoints_iter(Traj,1,h)
% plot3(Keypoints_iter(1,:),Keypoints_iter(2,:),Keypoints_iter(3,:),'r');
for j=1:k      
    Keypoints_iter= Cal_Keypoints_iter(Traj,j,h);
    plot3(Keypoints_iter(1,:),Keypoints_iter(2,:),Keypoints_iter(3,:),'r');
end
    
    

