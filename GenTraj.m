%Author:Wei
%Create date:2020/04/02
%Abstract:���ݹؽڵ�ͻ����ĳ�ʼλ�ã���ֵ������ɢ�Ĺ켣��
function [Traj,k]=GenTraj(Keypoints,Pb_init)   
Keypoints=Keypoints(1:3,:);
%plot3(Keypoints(1,:),Keypoints(2,:),Keypoints(3,:));
[~,n]=size(Keypoints);
Traj_Cur=cell(1,n-1);  %���ߵĹ켣

% for i=1:n-2
%    A= interpol([Keypoints(:,i),Keypoints(:,i+1),Keypoints(:,i+2)],3);  %�ⲿ�ֲ�ֵû��������ʹ��ʦ�ֵĴ��룬��ͷ�����   
%        %�˲�ֵ����Ŀǰ�������⣬��㲢�ǵ�һ��Keypoints
%    [~,m]=size(A);
%    Traj_Cur{1,i}= A(:,2:m);   %ǰ����������һ���������ظ���ȥ��
% end

for i=1:n-1
    Traj_Cur{1,i}=interpol_line(Keypoints(:,i),Keypoints(:,i+1),130);  % ��������Բ�ֵ
end
Traj_Cur=cell2mat(Traj_Cur);
[max,~]=maximum(Traj_Cur);  %�������ɵĲ�ֵ�����У����ڵ���ɢ�������ֵ����������ֵ��Ч��
% max
% min
length_stra=Keypoints(3,1)-Pb_init(3);  %ֱ�߶ι켣�ĳ���Ϊ������Z�����ȥ������ʼλ�õ�Z����
k=ceil(length_stra/max);  %ֱ�߶ι켣�ϵ����Ŀ,����ȡ��
Traj_Stra=zeros(3,k+1);
for i=1:k
    Traj_Stra(:,i)=[Pb_init(1),Pb_init(2),Pb_init(3)+(i-1)*max];
end
Traj_Stra(:,k+1)=Keypoints(1:3,1);
Traj=[Traj_Stra,Traj_Cur];
%[max1,~]=maximum(Traj);  %�������ɵĲ�ֵ�����У����ڵ���ɢ�������ֵ����������ֵ��Ч��
% max1
%plot3(Traj(1,:),Traj(2,:),Traj(3,:));
end