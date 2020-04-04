%Author:Wei
%Create date:2020/04/02
%Abstract:根据上下表面圆的坐标，绘制圆柱
function cy_draw(cy_cor1,cy_cor2)
x=[cy_cor1(1,:);cy_cor2(1,:)]; %cy_cor1有四行，为圆柱下表面部分的坐标，2为上表面
y=[cy_cor1(2,:);cy_cor2(2,:)];
z=[cy_cor1(3,:);cy_cor2(3,:)];
surf(x,y,z,'FaceColor',[1 0.4 0.6],'FaceAlpha',0.5,'EdgeColor','none');  %绘制圆柱侧面
hold on;
fill3(x(1,:),y(1,:),z(1,:),'b');       %绘制圆柱下盖
hold on;
fill3(x(2,:),y(2,:),z(2,:),'b');       %圆柱上盖
hold on;
end