%define function
function [t0, t1, t2, t3, a] = forKinDW(angle, length1, length2)
%define and assign function variables
syms t l2 l3;


%compute symbolic transformation matrices, without values
%dh parameters unique to manipulator
p = [0, 870, -pi/2, t;...
    0, l2, -pi/2, 0;...
    0, l3,0,0;];


%compute transformation matrix 1 with given theta, l2, and l3
t1= [cos(p(1,4)), -sin(p(1,4))*cos(p(1,3)), sin(p(1,4))*sin(p(1,3)), p(1,1)*cos(p(1,4));
    sin(p(1,4)), cos(p(1,4))*cos(p(1,3)), -cos(p(1,4))*sin(p(1,3)), p(1,1)*sin(p(1,4));
    0, sin(p(1,3)), cos(p(1,3)), p(1,2);
    0,0,0,1;];

%compute transformation matrix 2
t2= [cos(p(2,4)), -sin(p(2,4))*cos(p(2,3)), sin(p(2,4))*sin(p(2,3)), p(2,1)*cos(p(2,4));
    sin(p(2,4)), cos(p(2,4))*cos(p(2,3)), -cos(p(2,4))*sin(p(2,3)), p(2,1)*sin(p(2,4));
    0, sin(p(2,3)), cos(p(2,3)), p(2,2);
    0,0,0,1;];
%compute transformation matrix 3
t3= [cos(p(3,4)), -sin(p(3,4))*cos(p(3,3)), sin(p(3,4))*sin(p(3,3)), p(3,1)*cos(p(3,4));
    sin(p(3,4)), cos(p(3,4))*cos(p(3,3)), -cos(p(3,4))*sin(p(3,3)), p(3,1)*sin(p(3,4));
    0, sin(p(3,3)), cos(p(3,3)), p(3,2);
    0,0,0,1;];

%multiply transformation matrices
a=(t1*t2*t3);

%Compute real matrices with values
t=angle;
l2=length1;
l3=length2;

p = [0, 870, -pi/2, t;...
    0, l2, -pi/2, 0;...
    0, l3,0,0;];


t1= [cos(p(1,4)), -sin(p(1,4))*cos(p(1,3)), sin(p(1,4))*sin(p(1,3)), p(1,1)*cos(p(1,4));
    sin(p(1,4)), cos(p(1,4))*cos(p(1,3)), -cos(p(1,4))*sin(p(1,3)), p(1,1)*sin(p(1,4));
    0, sin(p(1,3)), cos(p(1,3)), p(1,2);
    0,0,0,1;];

%compute transformation matrix 2
t2= [cos(p(2,4)), -sin(p(2,4))*cos(p(2,3)), sin(p(2,4))*sin(p(2,3)), p(2,1)*cos(p(2,4));
    sin(p(2,4)), cos(p(2,4))*cos(p(2,3)), -cos(p(2,4))*sin(p(2,3)), p(2,1)*sin(p(2,4));
    0, sin(p(2,3)), cos(p(2,3)), p(2,2);
    0,0,0,1;];
%compute transformation matrix 3
t3= [cos(p(3,4)), -sin(p(3,4))*cos(p(3,3)), sin(p(3,4))*sin(p(3,3)), p(3,1)*cos(p(3,4));
    sin(p(3,4)), cos(p(3,4))*cos(p(3,3)), -cos(p(3,4))*sin(p(3,3)), p(3,1)*sin(p(3,4));
    0, sin(p(3,3)), cos(p(3,3)), p(3,2);
    0,0,0,1;];

 t0=(t1*t2*t3);
%t0=int16(a)


end
