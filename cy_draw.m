%Author:Wei
%Create date:2020/04/02
%Abstract:�������±���Բ�����꣬����Բ��
function cy_draw(cy_cor1,cy_cor2)
x=[cy_cor1(1,:);cy_cor2(1,:)]; %cy_cor1�����У�ΪԲ���±��沿�ֵ����꣬2Ϊ�ϱ���
y=[cy_cor1(2,:);cy_cor2(2,:)];
z=[cy_cor1(3,:);cy_cor2(3,:)];
surf(x,y,z,'FaceColor',[1 0.4 0.6],'FaceAlpha',0.5,'EdgeColor','none');  %����Բ������
hold on;
fill3(x(1,:),y(1,:),z(1,:),'b');       %����Բ���¸�
hold on;
fill3(x(2,:),y(2,:),z(2,:),'b');       %Բ���ϸ�
hold on;
end