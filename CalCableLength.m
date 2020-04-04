%Author:Wei
%Create date:2020/03/30
%Abstract:根据各关节变换矩阵，计算各个绳长
function CableLength=CalCableLength(CableTheta,Trans,linkl,jointl)
r=19; %绳所在的小圆半径
CableLength=zeros(12,3);%各个绳的总长
CableLength_joint=zeros(12,3);%每个关节处的各个绳长
for i=1:12
    for j=1:3
        cor_a=[r*cosd(CableTheta(i,j));r*sind(CableTheta(i,j));0;1]; %a为该绳坐标（坐标系为在上一个关节点处的坐标系）
        a1=[1 0 0 0;0 1 0 0;0 0 1 linkl+jointl;0 0 0 1]*cor_a;  %a1为绳在关节近端接触点中的坐标（坐标系为在上一个关节点处的坐标系）
        A=cell2mat(Trans(1,i)); %将cell型转化为矩阵
        a2=A*[1 0 0 0;0 1 0 0;0 0 1 jointl;0 0 0 1] *cor_a;%a2为绳在关节近端接触点中的坐标（坐标系为在上一个关节点处的坐标系）
        a1=a1(1:3);
        a2=a2(1:3);
        CableLength_joint(i,j)=norm(a1-a2);
    end
end
for i=1:12
    for j=1:i
        CableLength(i,:)=CableLength(i,:)+linkl+CableLength_joint(j,:);
    end
end
end

    

