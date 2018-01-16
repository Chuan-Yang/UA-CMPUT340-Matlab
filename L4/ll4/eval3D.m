clear all;
robot3D('new');
load('human_data.mat');
load('walk1.mat');
thetaL = [-pi/6;0;-pi/12;pi/3];
thetaR = [-pi/6;0;-pi/12;pi/3];

for i=1:size(L,2)
    thetaL = invKin3D(Ml, thetaL, L(:,i));%
    thetaR = invKin3D(Mr, thetaR, R(:,i));%
    theta = [thetaL; thetaR];
    robot3D(humanInterp(drad, theta));
    %pause(0.05);
end