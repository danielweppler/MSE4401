%Plot obstacles

[X Y Z]=meshgrid(-300:100:300, 300, 0:100:500);
front=[reshape(X,[],1),reshape(Y,[],1),reshape(Z,[],1)];
scatter3(front(:,1), front(:,2), front(:,3))
hold on
%back
[X Y Z]=meshgrid(-300:100:300, 900, 0:100:500);
back=[reshape(X,[],1),reshape(Y,[],1),reshape(Z,[],1)];
scatter3(back(:,1), back(:,2), back(:,3))
%left
[X Y Z]=meshgrid(-300, 300:100:900, 0:100:500);
left=[reshape(X,[],1),reshape(Y,[],1),reshape(Z,[],1)];
scatter3(left(:,1), left(:,2), left(:,3))

%right
[X Y Z]=meshgrid(300, 300:100:900, 0:100:500);
right=[reshape(X,[],1),reshape(Y,[],1),reshape(Z,[],1)];
scatter3(right(:,1), right(:,2), right(:,3))

%inspector position
inspectorPos = zeros(11,3);
inspectorPos(:,1)=-277.1;
inspectorPos(:,2)=1160;
inspectorPos(:,3)=(0:100:1000)';
scatter3(inspectorPos(:,1),inspectorPos(:,2), inspectorPos(:,3))

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


loc=0;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Configuration 1 - Start Position%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

q1= [pi/8, 1200, 300]; %STARTING VALUE
%tested with 0,400,870 and pi/8, 1200, 300
t0=forKinDW(q1(1), q1(2), q1(3));
pos1=([t0(1,4), t0(2,4), t0(3,4)]);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Configuration 2 - End Position%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
q2= [-pi/7, 900, 500]; %ENDING VALUE 
%tested with pi/8,1200,300 and -pi/7, 900, 500

%EE Position
t1=forKinDW(q2(1), q2(2), q2(3));
pos2=([t1(1,4), t1(2,4), t1(3,4)]);


scatter3(pos1(1), pos1(2), pos1(3))
xlabel('x-axis')
ylabel('y-axis')
zlabel('z-axis')
grid on
hold on
scatter3(pos2(1), pos2(2), pos2(3))


qInt=q1;
%check torque on each joint
torqueInt = generateField(pos1, pos2);


while loc ==0

% posTest = posInt + 50*forceInt/norm(forceInt);
%posInt = posTest;

%change joint value based on torque
qInt=q1 + 50000*torqueInt/norm(torqueInt);
qInt(2)=q1(2) + 10000*torqueInt(2)/norm(torqueInt);
qInt(1)=q1(1) + 0.00000000001*pi*torqueInt(1);

%convert back to XYZ
 t0= forKinDW(qInt(1), qInt(2),qInt(3));
posOld = posInt;
 posInt = ([t0(1,4), t0(2,4), t0(3,4)]);

%generate new torque values
q1=qInt;

torqueInt = generateField(posInt, pos2);

scatter3(posInt(1), posInt(2), posInt(3))

%if within 5cm
if norm(posInt-pos2) < 50
loc =1;
end
forceInt = generateField(posInt, pos2);
end

