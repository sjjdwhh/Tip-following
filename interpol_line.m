%Author:Wei
%Create date:2020/04/0
%Abstract:���ݹؽڵ�ͻ����ĳ�ʼλ�ã���ֵ�������Ե���ɢ�Ĺ켣��
function Cur=interpol_line(K1,K2,m)
Cur=zeros(3,m);
dif=(K2-K1)/m;
for i=1:m
    Cur(:,i)=K1+dif*i;
end
end