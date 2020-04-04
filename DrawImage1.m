%Author:Wei
%Create date:2020/04/01
%Abstract:绘制机器人当前图像
function DrawImage1(linkl,linkr,jointl,Trans)
% function DrawImage(linkl,linkr,jointl,Pb,Trans)
[x,y,z]=cylinder;
z=z*linkl+jointl;
x=x*linkr;
y=y*linkr;
image_cor=cell(4,13);% 存储第一段机器人初始位置时的各部分坐标，其中前两行是圆柱下上表面圆的坐标，第三四行是万向轴
one=ones(1,21);  %变换阵为4*4，要给坐标补一列1才能相乘
image_cor{1,1}=[x(1,:);y(1,:);z(1,:);one];
image_cor{2,1}=[x(2,:);y(2,:);z(2,:);one];
a=0;  % [a,b,c]为关节1的中心点的坐标
b=0;
c=linkl+2*jointl;
%以[a,b,c]为中心绘制两个长方体，表示万向轴
a1=15;  %万向轴长度的一半    
b1=4;   %万向轴宽度的一半
c1=4;   %高度的一半
x1=[a-a1,a-a1,a-a1,a-a1,a+a1,a+a1,a+a1,a+a1];   % x1,y1,z1为万向轴中代表x轴的长方体
y1=[b+b1,b-b1,b-b1,b+b1,b+b1,b-b1,b-b1,b+b1];
z1=[c+c1,c+c1,c-c1,c-c1,c+c1,c+c1,c-c1,c-c1];
y2=x1;     % x2,y2,z2为万向轴中代表y轴的长方体,只需将长方体1绕Z轴转动90°
x2=y1;
z2=z1;
one=ones(1,8);
image_cor{3,1}=[x1;y1;z1;one];
image_cor{4,1}=[x2;y2;z2;one];
for i=2:13
    for j=1:4
%         TransBase1=TransBase{1,i}; %将cell型转化成矩阵，用于计算,也可直接用花括号
%         image_cor1=cell2mat(image_cor(j,1)); %将cell型转化成矩阵，用于计算
        image_cor{j,i}=Trans{1,i}*image_cor{j,i-1};
    end
    cy_cor1=image_cor{1,i};  %第i段,圆柱下表面部分的坐标
    cy_cor2=image_cor{2,i};  %第i段,圆柱上表面部分的坐标
    cardan_cor1=image_cor{3,i};  %第i段,万向节1部分的坐标
    cardan_cor2=image_cor{4,i};    %第i段,万向节2部分的坐标
    
    cy_draw(cy_cor1,cy_cor2);     %根据坐标绘制圆柱
    if i<13  %根据坐标绘制万向节，末端处不绘制
        cardan_draw(cardan_cor1);
        cardan_draw(cardan_cor2);
    end
    axis([-2000,2000,-2000,2000,-100,3000]);
end
end
