%Author:Wei
%Create date:2020/03/30
%Abstract:���ݸ��ؽڱ任���󣬼����������
function CableLength=CalCableLength(CableTheta,Trans,linkl,jointl)
r=19; %�����ڵ�СԲ�뾶
CableLength=zeros(12,3);%���������ܳ�
CableLength_joint=zeros(12,3);%ÿ���ؽڴ��ĸ�������
for i=1:12
    for j=1:3
        cor_a=[r*cosd(CableTheta(i,j));r*sind(CableTheta(i,j));0;1]; %aΪ�������꣨����ϵΪ����һ���ؽڵ㴦������ϵ��
        a1=[1 0 0 0;0 1 0 0;0 0 1 linkl+jointl;0 0 0 1]*cor_a;  %a1Ϊ���ڹؽڽ��˽Ӵ����е����꣨����ϵΪ����һ���ؽڵ㴦������ϵ��
        A=cell2mat(Trans(1,i)); %��cell��ת��Ϊ����
        a2=A*[1 0 0 0;0 1 0 0;0 0 1 jointl;0 0 0 1] *cor_a;%a2Ϊ���ڹؽڽ��˽Ӵ����е����꣨����ϵΪ����һ���ؽڵ㴦������ϵ��
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

    

