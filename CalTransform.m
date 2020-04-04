%Author:Wei
%Create date:2020/04/01
%Abstract:ÿ���ؼ��㴦����һ������ϵ�����ݵ�������͸���ת�ǣ�����任����TransΪ��������ϵ�任��TransBaseΪ������ϵ�����������ϵ�ı任��
function [Keypoints,Trans,TransBase] = CalTransform(h,theta,Pb)
Trans=cell(1,13);     %TransΪÿ���ؽڵ㴦������ϵ�������һ����������ϵ�ı任���󣬶�������һ��ĩ�˴�
TransBase=cell(1,14);  %TransBaseΪÿ���ؽڵ㴦������ϵ�������������ϵ�ı任����
Keypoints=zeros(4,14); %KeypointsΪÿ���ؽڵ�����������ϵ�����꣬��������ĩ�˵�
Keypoints(:,1)=[Pb(1);Pb(2);Pb(3);1];
for i=1:13
    Trans{1,i}=[cosd(theta(i,2)),sind(theta(i,2))*sind(theta(i,1)),sind(theta(i,2))*cosd(theta(i,1)),0;...
        0,cosd(theta(i,1)),-sind(theta(i,1)),0;...
        -sind(theta(i,2)),cosd(theta(i,2))*sind(theta(i,1)),cosd(theta(i,2))*cosd(theta(i,1)),h(i);...
        0,0,0,1];   
end
TransBase{1,1}=[1 0 0 Pb(1);0 1 0 Pb(2);0 0 1 Pb(3);0 0 0 1];% BaseΪ��һ����������������ϵ�е�λ��
for j=2:14
    TransBase{1,j}=TransBase{1,j-1}*Trans{1,j-1};%������ϵ�������������ϵ�ı任������һ������ϵ����������ϵ�任��ĳ˻��õ�
%     for i=1:j
%         TransBase{1,j}=TransBase{1,j}*Trans{1,i}; %������ϵ�������������ϵ�ı任������������ϵ���۳˵õ�
%     end
    Keypoints(:,j)=TransBase{1,j}*[0;0;0;1];
    
end
fid=fopen('C:\Users\sjjdw\Desktop\softmare\Keypoints.txt','wt');
for i = 1 : 3   % ��ǰ���У�Ҳ�������꣬����Keypoints.txt��
	fprintf(fid, '%g\t', Keypoints(i, :));
	fprintf(fid, '\n');
end
fclose(fid);
end


