close all;
clear all;
addpath /cshome/vis/data
robot3D('new');
load('human_data.mat');
load('walk2.mat');


Lp = [-pi/6;0;pi/12;pi/2];
Rp = [-pi/6;0;-pi/12;pi/2];

for i=1:size(L,2)
   theta1 = invKin3D(Ml,Lp,L(:,i));
   theta2 = invKin3D(Mr,Rp,R(:,i));
   theta=[theta1;theta2];
   robot3D(humanInterp(drad,theta))
   pause(0.05);
end




function [pos,J]=evalRobot3D(M,theta)

    Rx_t1 = [1 0 0 0; 0 cos(theta(1)) -sin(theta(1)) 0; 0 sin(theta(1)) cos(theta(1)) 0; 0 0 0 1];
    Ry = [cos(theta(2)) 0 sin(theta(2)) 0; 0 1 0 0; -sin(theta(2)) 0 cos(theta(2)) 0; 0 0 0 1];
    Rz = [cos(theta(3)) -sin(theta(3)) 0 0; sin(theta(3)) cos(theta(3)) 0 0; 0 0 1 0; 0 0 0 1];
    Rx_t4 = [1 0 0 0; 0 cos(theta(4)) -sin(theta(4)) 0; 0 sin(theta(4)) cos(theta(4)) 0; 0 0 0 1];
    
    pos = (M{1}*Rz*Ry*Rx_t1*M{2}*Rx_t4*M{3})*[0,0,0,1]';
    pos = pos(1:3,:);
    
    dRx_t1 = [0 0 0 0; 0 -sin(theta(1)) -cos(theta(1)) 0; 0 cos(theta(1)) -sin(theta(1)) 0; 0 0 0 0];
    dRy = [-sin(theta(2)) 0 cos(theta(2)) 0; 0 0 0 0; -cos(theta(2)) 0 -sin(theta(2)) 0; 0 0 0 0];
    dRz = [sin(theta(3)) -cos(theta(3)) 0 0; cos(theta(3)) -sin(theta(3)) 0 0; 0 0 0 0; 0 0 0 0];
    dRx_t4 = [0 0 0 0; 0 -sin(theta(4)) -cos(theta(4)) 0; 0 cos(theta(4)) -sin(theta(4)) 0; 0 0 0 0];
    
    J(:,1) = (M{1}*Rz*Ry*dRx_t1*M{2}*Rx_t4*M{3})*[0,0,0,1]';
    J(:,2) = (M{1}*Rz*dRy*Rx_t1*M{2}*Rx_t4*M{3})*[0,0,0,1]';
    J(:,3) = (M{1}*dRz*Ry*Rx_t1*M{2}*Rx_t4*M{3})*[0,0,0,1]';
    J(:,4) = (M{1}*Rz*Ry*Rx_t1*M{2}*dRx_t4*M{3})*[0,0,0,1]';
    J = J(1:3,:);

end

function theta=invKin3D(M,theta,pos) 
    theta0 = theta;
    n = 5000;
    for i =1:n
           [posN,J] = evalRobot3D(M,theta);
           f = posN-pos;
           s = -J\f;
           theta = theta0 + s; % update theta before possible break
           
           if abs(norm(posN-pos)) < 0.0001
              break;   
           end
           
           theta0 = theta;
        end

end







