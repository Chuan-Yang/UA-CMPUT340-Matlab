function J=fdJacob2D(l,theta,alpha)

p1 = (evalRobot2D(l,theta+[alpha;0])-evalRobot2D(l,theta-[alpha;0]))/(2*alpha);
p2 = (evalRobot2D(l,theta+[0;alpha])-evalRobot2D(l,theta-[0;alpha]))/(2*alpha);
J = [p1 p2];

end

