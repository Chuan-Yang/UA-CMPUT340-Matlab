l = [0.5,0.5]';
t = [pi/4,pi/4]';
a = 0.0001;
[~,JN] = evalRobot2D(l,t)
JC = fdJacob2D(l,t,a)
d = norm(JN)-norm(JC)
