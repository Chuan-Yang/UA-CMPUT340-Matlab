function [pos,J]=evalRobot3D(M,theta)

Rx_theta1=[1    0           0              0
           0 cos(theta(1)) -sin(theta(1))  0
           0 sin(theta(1)) cos(theta(1))   0
           0    0           0              1];
       
Ry=[cos(theta(2)) 0 sin(theta(2)) 0
    0 1 0 0
    -sin(theta(2)) 0 cos(theta(2)) 0
    0 0 0 1];

Rz=[cos(theta(3)) -sin(theta(3)) 0 0
    sin(theta(3)) cos(theta(3)) 0 0
    0 0 1 0
    0 0 0 1];

Rx_theta4=[1    0           0              0
           0 cos(theta(4)) -sin(theta(4))  0
           0 sin(theta(4)) cos(theta(4))   0
           0    0           0              1];
                     
pos = M{1}*Rz*Ry*Rx_theta1*M{2}*Rx_theta4*M{3}*[0;0;0;1];      
pos = pos(1:3,:);

d_Rx_theta1=[0    0           0            0
           0 -sin(theta(1)) -cos(theta(1)) 0
           0 cos(theta(1)) -sin(theta(1))  0
           0    0           0              0];
d_Ry=[-sin(theta(2)) 0 cos(theta(2)) 0
       0 0 0 0
      -cos(theta(2)) 0 -sin(theta(2)) 0
       0 0 0 0];

d_Rz=[-sin(theta(3)) -cos(theta(3)) 0 0
       cos(theta(3)) -sin(theta(3)) 0 0
       0 0 0 0
       0 0 0 0];

d_Rx_theta4=[0    0           0            0
           0 -sin(theta(4)) -cos(theta(4)) 0
           0 cos(theta(4)) -sin(theta(4))  0
           0    0           0              0];
       
J(:,1) = M{1}*Rz*Ry*d_Rx_theta1*M{2}*Rx_theta4*M{3}*[0;0;0;1];
J(:,2) = M{1}*Rz*d_Ry*Rx_theta1*M{2}*Rx_theta4*M{3}*[0;0;0;1];
J(:,3) = M{1}*d_Rz*Ry*Rx_theta1*M{2}*Rx_theta4*M{3}*[0;0;0;1];
J(:,4) = M{1}*Rz*Ry*Rx_theta1*M{2}*d_Rx_theta4*M{3}*[0;0;0;1];
J = J(1:3,:);
end

