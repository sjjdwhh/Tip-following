%Author:Wei
%Create date:2020/04/02
%Abstract:�������±���Բ�����꣬���������
function cardan_draw(cardan_cor)
x=cardan_cor(1,:);
y=cardan_cor(2,:);
z=cardan_cor(3,:);

% 0.5*x(1)+0.5*x(5)
% 0.5*y(1)+0.5*y(2)
% 0.5*z(1)+0.5*z(3)

patch(x,y,z,'b');
view(3);
hold on;
end