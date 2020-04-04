%Author:Wei
%Create date:2020/04/0
%Abstract:根据关节点和基座的初始位置，插值生成线性的离散的轨迹点
function Cur=interpol_line(K1,K2,m)
Cur=zeros(3,m);
dif=(K2-K1)/m;
for i=1:m
    Cur(:,i)=K1+dif*i;
end
end