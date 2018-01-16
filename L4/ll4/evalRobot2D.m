function [pos,J]=evalRobot2D(l,theta)   

J=zeros(2);
syms L1 L2 t1 t2 
f1 = L1*cos(t1)+L2*cos(t1+t2);
f2 = L1*sin(t1)+L2*sin(t1+t2);
d1 = diff(f1,t1);
d2 = diff(f1,t2);
d3 = diff(f2,t1);
d4 = diff(f2,t2);

J(1,1) = vpa(subs(d1,{L1,L2,t1,t2},{l(1),l(2),theta(1),theta(2)}));
J(1,2) = vpa(subs(d2,{L1,L2,t1,t2},{l(1),l(2),theta(1),theta(2)}));
J(2,1) = vpa(subs(d3,[L1,L2,t1,t2],[l(1),l(2),theta(1),theta(2)]));
J(2,2) = vpa(subs(d4,[L1,L2,t1,t2],[l(1),l(2),theta(1),theta(2)]));

pos(1,1) = l(1)*cos(theta(1))+l(2)*cos(theta(1)+theta(2));
pos(2,1) = l(1)*sin(theta(1))+l(2)*sin(theta(1)+theta(2));
end