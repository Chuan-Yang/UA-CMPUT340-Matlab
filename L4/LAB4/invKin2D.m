function theta = invKin2D(l,theta0,pos,n,mode)
    
if mode == 0    %Newton's method
    for i = 1:n
        [p,J] = evalRobot2D(l,theta0);
        f(1,1)=l(1)*cos(theta0(1))+l(2)*cos(theta0(1)+theta0(2))-pos(1);
        f(2,1)=l(1)*sin(theta0(1))+l(2)*sin(theta0(1)+theta0(2))-pos(2);
        s = (J\-f);
        theta = theta0 + s;
        differ = norm(p-pos);
        if abs(differ) < 0.0001
            break;
        end
        theta0 = theta;
    end
elseif mode == 1    %Broyden's method
    [~,B] = evalRobot2D(l,theta0);          
    for i = 1:n
        [p,~]=evalRobot2D(l,theta0);
        %Solve Bk*sk=-f(k)for sk
        f_k(1,1)=l(1)*cos(theta0(1))+l(2)*cos(theta0(1)+theta0(2))-pos(1);
        f_k(2,1)=l(1)*sin(theta0(1))+l(2)*sin(theta0(1)+theta0(2))-pos(2);
        s = (B\-f_k);
        
        %xk+1=xk+sk
        theta = theta0 + s;
        
        %yk=f(xk+1)-f(x)
        f_k1(1,1)=l(1)*cos(theta(1))+l(2)*cos(theta(1)+theta(2))-pos(1);
        f_k1(2,1)=l(1)*sin(theta(1))+l(2)*sin(theta(1)+theta(2))-pos(2);
        y = f_k1-f_k;
        
        B = B + ((y-B*s)*s')/(s'*s);
        differ = norm(p-pos);
        if abs(differ) < 0.0001
            break;
        end
        theta0 = theta;
        end
    end
end

