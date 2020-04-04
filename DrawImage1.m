%Author:Wei
%Create date:2020/04/01
%Abstract:���ƻ����˵�ǰͼ��
function DrawImage1(linkl,linkr,jointl,Trans)
% function DrawImage(linkl,linkr,jointl,Pb,Trans)
[x,y,z]=cylinder;
z=z*linkl+jointl;
x=x*linkr;
y=y*linkr;
image_cor=cell(4,13);% �洢��һ�λ����˳�ʼλ��ʱ�ĸ��������꣬����ǰ������Բ�����ϱ���Բ�����꣬����������������
one=ones(1,21);  %�任��Ϊ4*4��Ҫ�����겹һ��1�������
image_cor{1,1}=[x(1,:);y(1,:);z(1,:);one];
image_cor{2,1}=[x(2,:);y(2,:);z(2,:);one];
a=0;  % [a,b,c]Ϊ�ؽ�1�����ĵ������
b=0;
c=linkl+2*jointl;
%��[a,b,c]Ϊ���Ļ������������壬��ʾ������
a1=15;  %�����᳤�ȵ�һ��    
b1=4;   %�������ȵ�һ��
c1=4;   %�߶ȵ�һ��
x1=[a-a1,a-a1,a-a1,a-a1,a+a1,a+a1,a+a1,a+a1];   % x1,y1,z1Ϊ�������д���x��ĳ�����
y1=[b+b1,b-b1,b-b1,b+b1,b+b1,b-b1,b-b1,b+b1];
z1=[c+c1,c+c1,c-c1,c-c1,c+c1,c+c1,c-c1,c-c1];
y2=x1;     % x2,y2,z2Ϊ�������д���y��ĳ�����,ֻ�轫������1��Z��ת��90��
x2=y1;
z2=z1;
one=ones(1,8);
image_cor{3,1}=[x1;y1;z1;one];
image_cor{4,1}=[x2;y2;z2;one];
for i=2:13
    for j=1:4
%         TransBase1=TransBase{1,i}; %��cell��ת���ɾ������ڼ���,Ҳ��ֱ���û�����
%         image_cor1=cell2mat(image_cor(j,1)); %��cell��ת���ɾ������ڼ���
        image_cor{j,i}=Trans{1,i}*image_cor{j,i-1};
    end
    cy_cor1=image_cor{1,i};  %��i��,Բ���±��沿�ֵ�����
    cy_cor2=image_cor{2,i};  %��i��,Բ���ϱ��沿�ֵ�����
    cardan_cor1=image_cor{3,i};  %��i��,�����1���ֵ�����
    cardan_cor2=image_cor{4,i};    %��i��,�����2���ֵ�����
    
    cy_draw(cy_cor1,cy_cor2);     %�����������Բ��
    if i<13  %���������������ڣ�ĩ�˴�������
        cardan_draw(cardan_cor1);
        cardan_draw(cardan_cor2);
    end
    axis([-2000,2000,-2000,2000,-100,3000]);
end
end
