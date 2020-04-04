%Author:Wei
%Create date:2020/04/02
%Abstract:根据关节点和基座的初始位置，插值生成离散的轨迹点
function [Traj,k]=GenTraj(Keypoints,Pb_init)   
Keypoints=Keypoints(1:3,:);
%plot3(Keypoints(1,:),Keypoints(2,:),Keypoints(3,:));
[~,n]=size(Keypoints);
Traj_Cur=cell(1,n-1);  %曲线的轨迹

% for i=1:n-2
%    A= interpol([Keypoints(:,i),Keypoints(:,i+1),Keypoints(:,i+2)],3);  %这部分插值没看懂，先使用师兄的代码，回头再添加   
%        %此插值函数目前存在问题，起点并非第一个Keypoints
%    [~,m]=size(A);
%    Traj_Cur{1,i}= A(:,2:m);   %前两个点与上一步的最后点重复，去除
% end

for i=1:n-1
    Traj_Cur{1,i}=interpol_line(Keypoints(:,i),Keypoints(:,i+1),130);  % 两点间线性插值
end
Traj_Cur=cell2mat(Traj_Cur);
[max,~]=maximum(Traj_Cur);  %计算生成的插值曲线中，相邻的离散点间距的最值，以评估插值的效果
% max
% min
length_stra=Keypoints(3,1)-Pb_init(3);  %直线段轨迹的长度为底座的Z坐标减去底座初始位置的Z坐标
k=ceil(length_stra/max);  %直线段轨迹上点的数目,向上取整
Traj_Stra=zeros(3,k+1);
for i=1:k
    Traj_Stra(:,i)=[Pb_init(1),Pb_init(2),Pb_init(3)+(i-1)*max];
end
Traj_Stra(:,k+1)=Keypoints(1:3,1);
Traj=[Traj_Stra,Traj_Cur];
%[max1,~]=maximum(Traj);  %计算生成的插值曲线中，相邻的离散点间距的最值，以评估插值的效果
% max1
%plot3(Traj(1,:),Traj(2,:),Traj(3,:));
end