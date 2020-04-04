%Author:Wei
%Create date:2020/04/03
%Abstract:计算生成的插值曲线中，相邻的离散点间距的最值，以评估插值的效果。如果最值接近，说明插值均匀
function [max,min]=maximum(Traj)
[~,s]=size(Traj);
min=norm([Traj(1,1)-Traj(1,2),Traj(2,1)-Traj(2,2),Traj(3,1)-Traj(3,2)]);
max=min;
for i=1:s-1
    r=norm([Traj(1,i)-Traj(1,i+1),Traj(2,i)-Traj(2,i+1),Traj(3,i)-Traj(3,i+1)]);
    if r>max
        max=r;
    elseif r<min-0.0001
        min=r;
    end
end
end

