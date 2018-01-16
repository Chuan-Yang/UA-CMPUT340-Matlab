function theta=invKin3D(M,theta,pos)
n = 100;

for i = 1:n
       [p,J] = evalRobot3D(M,theta);
       f = p-pos; 
       s = J\(-1*f);
       theta = theta+s;
       differ = norm(p-pos);
       if abs(differ) < 0.00001
          break;   
       end
	
end