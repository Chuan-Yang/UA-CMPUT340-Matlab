clear all
close all
addpath /cshome/vis/data
robot3D('new')
load('human_data.mat')
load('walk2.mat')

%different initials
Lp = [-pi/8;0;-pi/16;pi/4];
Rp = [-pi/8;0;pi/16;pi/4];
%Lp = [-pi/8;0;-pi/16;pi/5];
%Rp = [-pi/8;0;pi/16;pi/5];
%Lp = [-pi/6;0;-pi/12;pi/3];
%Rp = [-pi/6;0;pi/12;pi/3];
%Lp = [0;0-0;0];
%Rp = [0;0;0;0];

for i=1:size(L,2)
   Lp = invKin3D(Ml,Lp,L(:,i));
   Rp = invKin3D(Mr,Rp,R(:,i));
   theta=[Lp;Rp];
   robot3D(humanInterp(drad,theta))
   pause(0.02);
end