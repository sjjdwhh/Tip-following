%Author:Wei
%Create date:2020/03/31
%Abstract:������
clc
clear
close all

% theta=zeros(13,2); % ���ؽ�ת��
theta=load('theta.txt');    %thetaΪ13*2����ÿ��Ϊ����ڵ�X,Yת�ǡ�����ģ����һ��ָĩ�˸��أ�һ��Ϊ0����
%CableTheta=zeros(12,3);
CableTheta(:,1)=load('CableTheta.txt'); %���Ƹ��ڶε�����X�����ɵĽǶ�
CableTheta(:,2)=CableTheta(:,1)+120;
CableTheta(:,3)=CableTheta(:,1)-120;
Pb=[0 200 200];  %��������     �������Pb��
Pb_init=[0 200 0]; %��ʼ״̬ʱ�ĵ�������
linkl=143.5;
jointl=6.5;
linkr=30;
h=(2*jointl+linkl)*ones(1,13);   % hΪ���ڶεĳ��ȡ���ǰ���þ�Ϊ�㶨ֵ�������ɸ���
% theta=[];  %����ע�Ͳ��ֹ���Ϊд��Ƕ����ݡ���Ҫ����Ƕ�ʱ���ɴӴ˴�����
% [m, n] = size(theta);
% fid=fopen('C:\Users\sjjdw\Desktop\softmare\theta.txt','wt');
% for i = 1 : m
% 	fprintf(fid, '%g\t', theta(i, :));
% 	fprintf(fid, '\n');
% end
% fclose(fid);

[Keypoints,Trans,TransBase]=CalTransform(h,theta,Pb);   % ����任����KeypointsΪ�ؽڵ����꣬TransΪ��������ϵ�任��TransBaseΪ������ϵ�����������ϵ�ı任��
CableLength=CalCableLength(CableTheta,Trans,linkl,jointl); %���ݸ��ؽڱ任���󣬼���������� 
DrawImage(linkl,linkr,jointl,TransBase);  %���ƻ����˵�ǰͼ��
[Traj,k]=GenTraj(Keypoints,Pb_init); %���ݹؽڵ�ͻ����ĳ�ʼλ�ã���ֵ������ɢ�Ĺ켣�㡣kΪֱ�߶��ϵĵ�����Ҳ���ǻ����ӳ�ʼλ�õ�����λ���˶��Ĵ�����
%k������ֱ�߶ε����һ���㣬����������㡣����ֱ�߶�ʵ������k+1����

% Keypoints_iter= Cal_Keypoints_iter(Traj,k_Pb,h); %������ɢ�Ĺ켣�㣬�Լ���ǰ�������ڵĹ켣�㣬���㵱ǰ���йؼ����λ��
%                                                  %k_PbΪ��ǰ�������ڹ켣�㣬hΪ���εĳ���

% Keypoints_iter= Cal_Keypoints_iter(Traj,1,h)
% plot3(Keypoints_iter(1,:),Keypoints_iter(2,:),Keypoints_iter(3,:),'r');
for j=1:k      
    Keypoints_iter= Cal_Keypoints_iter(Traj,j,h);
    plot3(Keypoints_iter(1,:),Keypoints_iter(2,:),Keypoints_iter(3,:),'r');
end
    
    

