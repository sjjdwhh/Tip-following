%Author:Wei
%Create date:2020/04/03
%Abstract:这部分插值的实现，实在没看懂，先使用师兄的

function curve = interpol(x,k,maxpnt)
% x is an array consists of points[x1,x2...; y1,y2...;z1,z2...]
% k B-Spline's index
% maxpnt, generate at least maxpnt points to divide the spline

y = [x(1,:); x(2,:)];
z = [x(1,:); x(3,:)];
if nargin<2||isempty(k), k = 3; end   %如果输入参数的数量小于2或未输入k，则默认为三次样条曲线
[d,n] = size(x);

if n<k
   error(message('SPLINES:SPCRV:toofewpoints', sprintf( '%.0f', n ), sprintf( '%.0f', k )));
elseif k<2
   error(message('SPLINES:SPCRV:ordertoosmall', sprintf( '%.0f', k )));
else
   if k>2
      if nargin<3||isempty(maxpnt), maxpnt = 100; end   %若未输入生成的点数，默认生成100个点
      while n<maxpnt                            % iterate until the number of points >= maxpnt
         m = 2*n; 
         yy(:,2:2:m) = y; yy(:,1:2:m) = y;      % caculate Y after smooth
         zz(:,2:2:m) = z; zz(:,1:2:m) = z;      % caculate Z after smooth
         for r=2:k                              % iterate k-1 times to get the kth power B-Spline
            yy(:,2:m) = (yy(:,2:m)+yy(:,1:m-1))*.5;     % the formula of B-Spline
            zz(:,2:m) = (zz(:,2:m)+zz(:,1:m-1))*.5;     % the formula of B-Spline
         end
         y = yy(:,k:m); z = zz(:,k:m);
         n = m+1-k;
      end
   end
   curve = [y(1,:); y(2,:); z(2,:)];
end
