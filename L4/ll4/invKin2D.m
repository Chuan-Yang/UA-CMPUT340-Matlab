function theta=invKin2D(l,theta0,pos,n,mode)
if mode == 0
   for i =1:n
       [p,J] = evalRobot2D(l,theta0);
       f(1,1) = l(1)*cos(theta0(1))+l(2)*cos(theta0(1)+theta0(2))-pos(1);
       f(2,1) = l(1)*sin(theta0(1))+l(2)*sin(theta0(1)+theta0(2))-pos(2);
       s = J\(-1*f);
       theta = theta0+s;
       differ = norm(p-pos);
       if abs(differ) < 0.0001
          break;   
       end
       theta0 = theta;
   end
elseif mode == 1
    [~,J] = evalRobot2D(l,theta0);
    for i = 1:n 
        [p,~] = evalRobot2D(l,theta0);
        f(1,1) = l(1)*cos(theta0(1))+l(2)*cos(theta0(1)+theta0(2))-pos(1);
        f(2,1) = l(1)*sin(theta0(1))+l(2)*sin(theta0(1)+theta0(2))-pos(2);
        s = J\(-1*f);
        theta = theta0+s;
        y1 = f;
        fa = l(1)*cos(theta(1))+l(2)*cos(theta(1)+theta(2))-pos(1);
        fb = l(1)*sin(theta(1))+l(2)*sin(theta(1)+theta(2))-pos(2) ;
        y2 = [fa;fb]; 
        y = y2-y1;
        J = J+((y-J*s)*s')/(s'*s);
        differ = norm(p-pos);
        if abs(differ) < 0.0001
           break;   
        end
        theta0 = theta;
    end
end    
    
end