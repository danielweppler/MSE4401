function [real] = invKinDW(q)

dx=q(1);
dy=q(2);
dz=q(3);

%actual calculations
theta=atan2(-dx,dy);
l3=870-dz;
l2=sqrt(dx^2+dy^2);



real=double([theta l2 l3]);
end