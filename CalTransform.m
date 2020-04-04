%Author:Wei
%Create date:2020/04/01
%Abstract:每个关键点处建立一个坐标系。根据底座坐标和各个转角，计算变换矩阵。Trans为相邻坐标系变换阵，TransBase为各坐标系相对世界坐标系的变换阵
function [Keypoints,Trans,TransBase] = CalTransform(h,theta,Pb)
Trans=cell(1,13);     %Trans为每个关节点处的坐标系相对于上一个相邻坐标系的变换矩阵，额外增添一个末端处
TransBase=cell(1,14);  %TransBase为每个关节点处的坐标系相对于世界坐标系的变换矩阵
Keypoints=zeros(4,14); %Keypoints为每个关节的在世界坐标系中坐标，额外增添末端点
Keypoints(:,1)=[Pb(1);Pb(2);Pb(3);1];
for i=1:13
    Trans{1,i}=[cosd(theta(i,2)),sind(theta(i,2))*sind(theta(i,1)),sind(theta(i,2))*cosd(theta(i,1)),0;...
        0,cosd(theta(i,1)),-sind(theta(i,1)),0;...
        -sind(theta(i,2)),cosd(theta(i,2))*sind(theta(i,1)),cosd(theta(i,2))*cosd(theta(i,1)),h(i);...
        0,0,0,1];   
end
TransBase{1,1}=[1 0 0 Pb(1);0 1 0 Pb(2);0 0 1 Pb(3);0 0 0 1];% Base为第一个基座在世界坐标系中的位置
for j=2:14
    TransBase{1,j}=TransBase{1,j-1}*Trans{1,j-1};%各坐标系相对于世界坐标系的变换阵，由上一个坐标系与相邻坐标系变换阵的乘积得到
%     for i=1:j
%         TransBase{1,j}=TransBase{1,j}*Trans{1,i}; %各坐标系相对于世界坐标系的变换阵，由相邻坐标系间累乘得到
%     end
    Keypoints(:,j)=TransBase{1,j}*[0;0;0;1];
    
end
fid=fopen('C:\Users\sjjdw\Desktop\softmare\Keypoints.txt','wt');
for i = 1 : 3   % 将前三列，也即是坐标，存入Keypoints.txt中
	fprintf(fid, '%g\t', Keypoints(i, :));
	fprintf(fid, '\n');
end
fclose(fid);
end


