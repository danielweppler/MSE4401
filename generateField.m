%%%%%%%%
%Potential Fields Calculation
%Daniel Weppler - for MSE4401 Project Step 3
%Assumption - Only need to consider end effector as other joints cannot
%colide into any of the obstacles







function torque = generateField(pos1EE, pos2EE)

qNew=invKinDW(pos1EE);
jacobian=jacobianDW(qNew(1), qNew(2),qNew(3));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Attractive force of end position%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
attDist = 100000;
attMag = 1000000;
attForce=0;
distFrom = norm(pos1EE-pos2EE);

if distFrom <= 300;

    attForce = (-attMag*(pos1EE-pos2EE))/1000;

else %divide by 1000 to convert mm --> m
    attForce = (-500/1000*attMag*((pos1EE-pos2EE))/distFrom);
end

%%%%%%%%%%%%%%%%%
%Inspector Force%
%%%%%%%%%%%%%%%%%

%inspector position
inspectorPos = zeros(11,3);
inspectorPos(:,1)=-277.1;
inspectorPos(:,2)=1160;
inspectorPos(:,3)=(0:100:1000)';


%Inspector Parameters
repMagInsp = 100;
repDistInsp = 400;
repForceInsp = zeros(1,3);
% scatter3(inspectorPos(:,1),inspectorPos(:,2), inspectorPos(:,3))


for ii = 1:1:length(inspectorPos)

distFromInsp = norm(pos1EE-inspectorPos(ii,:));

if norm(pos1EE-inspectorPos(ii,:)) < repDistInsp

    grad=(pos1EE-inspectorPos(ii,:))/distFromInsp;

repForceInsp = repForceInsp + repMagInsp*(((1/(distFromInsp/1000))-(1/repDistInsp))*(1/((distFromInsp/1000)^2)))*grad;

else 

repForceInsp = repForceInsp+0;
end
end

%%%%%%%%%%%
%Box Force%
%%%%%%%%%%%

%Box Position

%Walls of Box
%front
[X Y Z]=meshgrid(-300:100:300, 300, 0:100:500);
front=[reshape(X,[],1),reshape(Y,[],1),reshape(Z,[],1)];
%scatter3(front(:,1), front(:,2), front(:,3))
%hold on
%back
[X Y Z]=meshgrid(-300:100:300, 900, 0:100:500);
back=[reshape(X,[],1),reshape(Y,[],1),reshape(Z,[],1)];
%scatter3(back(:,1), back(:,2), back(:,3))
%left
[X Y Z]=meshgrid(-300, 300:100:900, 0:100:500);
left=[reshape(X,[],1),reshape(Y,[],1),reshape(Z,[],1)];
%scatter3(left(:,1), left(:,2), left(:,3))

%right
[X Y Z]=meshgrid(300, 300:100:900, 0:100:500);
right=[reshape(X,[],1),reshape(Y,[],1),reshape(Z,[],1)];
%scatter3(right(:,1), right(:,2), right(:,3))

boxPos=[left; right; front; back];

%Box Parameters
repMagBox = 18.5;
repDistBox = 500;
repForceBox = zeros(1,3);


for ii = 1:1:length(boxPos)

distFromBox = norm(pos1EE-boxPos(ii,:));

if norm(pos1EE-boxPos(ii,:)) < repDistBox

    grad=(pos1EE-boxPos(ii,:))/distFromBox;
repForceBox = repForceBox + repMagBox*(((1/(distFromBox/1000))-(1/repDistBox))*(1/((distFromBox/1000)^2)))*grad;

else 

repForceBox = repForceBox+0;
end
end

torque=(jacobian(1:3,1:3)'*(attForce+repForceBox+repForceInsp)')';
end
