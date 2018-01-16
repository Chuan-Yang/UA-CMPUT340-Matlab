close all;
clear all;

load EllipsePoints

[V1,D1,t1,A1]=myPCA(Y1);
[V2,D2,t2,A2]=myPCA(Y2);
[V3,D3,t3,A3]=myPCA(Y3);

figure(1),plot(Y1(1,:),Y1(2,:),'.'),axis equal

axeplot(V1,D1,t1)

figure(2),plot(Y2(1,:),Y2(2,:),'.'),axis equal

axeplot(V2,D2,t2)

figure(3),plot(Y3(1,:),Y3(2,:),'.'),axis equal

axeplot(V3,D3,t3)

function [V,D,t,A]=myPCA(Y)
t=mean(Y,2);
Yn=Y-t*ones(1,size(Y,2));
C=(Yn*Yn')/size(Y,2);
[V,D]=eig(C);
A=V*(D^0.5);
end

function axeplot(V,D,t)
hold on
plot([t(1) 2*sqrt(D(1,1))*V(1,1)+t(1)],[t(2) 2*sqrt(D(1,1))*V(2,1)+t(2)],'r')
plot([t(1) 2*sqrt(D(2,2))*V(1,2)+t(1)],[t(2) 2*sqrt(D(2,2))*V(2,2)+t(2)],'g')
hold off
end