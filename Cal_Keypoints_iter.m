%Author:Wei
%Create date:2020/04/03
%Abstract:根据离散的轨迹点，以及当前基座所在的轨迹点，计算当前所有关键点的位置
%1：44，终于通了，可以睡觉了！
function kp=Cal_Keypoints_iter(Traj,k_Pb,h)  %kp为当前状态时关键点的坐标
[~,length]=size(Traj);
Traj=[Traj,Traj(:,length),Traj(:,length)];  %最后补两个点，使后面的搜索停止，不要溢出
kp=zeros(3,14);
kp(:,1)=Traj(:,k_Pb); %第一个关节点即为当前基座位置
kp_k=zeros(1,14);  %关键点在轨迹中的序号
kp_k(1,1)=k_Pb;
m=100;% 两个关节点在轨迹中序号的差值，默认初始为100

for i=2:14  
    H=h(1,i-1); %H为目标的与当前点的间距
%     H=156.5;
    flag=1;
    while flag==1
        d_1=norm(kp(:,i-1)-Traj(:,kp_k(1,i-1)+m-1));  % （第i-1个关节点）与（轨迹点往后数m-1个）的距离
        d_2=norm(kp(:,i-1)-Traj(:,kp_k(1,i-1)+m));   % （第i-1个关节点）与（轨迹点往后数m1个）的距离
        d_3=norm(kp(:,i-1)-Traj(:,kp_k(1,i-1)+m+1)); % （第i-1个关节点）与（轨迹点往后数m+1个）的距离
%         x1=kp_k(i-1)+m-1;
%         x2=kp_k(i-1)+m;
%         x3=kp_k(i-1)+m+1;
%         y=i-1;
%         d_1=norm(kp(:,y)-Traj(:,x1));  % （第i-1个关节点）与（轨迹点往后数m-1个）的距离
%         d_2=norm(kp(:,y)-Traj(:,x2));    % （第i-1个关节点）与（轨迹点往后数m1个）的距离
%         d_3=norm(kp(:,y)-Traj(:,x3));  % （第i-1个关节点）与（轨迹点往后数m+1个）的距离
        d1=abs(d_1-H);
        d2=abs(d_2-H);
        d3=abs(d_3-H);
        if (d1<d2)&&(d1<d3)   %若三者中，最近的那个，距离最接近H,则轨迹点前移
            m=m-1;
        elseif (d3<d2)&&(d3<d1)  %若三者中，最远的那个，距离最接近H,则轨迹点后移
            m=m+1;   
        elseif (d2<=d3)&&(d2<=d1)   %三者中，中间的点，距离最接近H
            flag=0;     %停止寻找“间距最接近杆长的点”
            if d1<d3    %最近的比最远的差值更接近L，因此真正的点应在d1和d2之间
                kp(:,i)=Traj(:,kp_k(1,i-1)+m)+(d2/(d1+d2))*(Traj(:,kp_k(1,i-1)+m-1)-Traj(:,kp_k(1,i-1)+m));
            elseif d1==d3
                kp(:,i)=Traj(:,kp_k(1,i-1)+m);
            elseif d1>d3
                kp(:,i)=Traj(:,kp_k(1,i-1)+m)+(d2/(d2+d3))*(Traj(:,kp_k(1,i-1)+m+1)-Traj(:,kp_k(1,i-1)+m));
            end
            kp_k(1,i)=kp_k(1,i-1)+m;
        end
    end
end
end

        
                
                
            

    