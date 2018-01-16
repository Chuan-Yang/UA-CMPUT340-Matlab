%This code is available in eval2D.m
% make sure you define n and mode
n = 50;
mode = 1;
ls=[0.5,0.5]';
t=rand(2,1); %Choose some random starting point.

alpha= 0.001;
[~,J1]=evalRobot2D(ls,t);

J2=fdJacob2D(ls,t,alpha);
disp(abs(norm(J1-J2)));
pause();

clf;
plotRobot2D(ls,t);
hold off;

while(1)
  desired=ginput(1)'; %Get desired position from user

  clf;
  plot(desired(1),desired(2),'*');
  hold on;
  plotRobot2D(ls,t,':');
  
  %Solve and display the position
  t=invKin2D(ls,t,desired,n,mode); 
  plotRobot2D(ls,t);
  hold off;
end


function [pos,J]=evalRobot2D(l,theta)

    % calculate x and y 
    pos(1,1)=l(1)*cos(theta(1))+l(2)*cos(theta(1)+theta(2));
    pos(2,1)=l(1)*sin(theta(1))+l(2)*sin(theta(1)+theta(2));
    
    J(1,1) = -l(1)*sin(theta(1)) - l(2)*sin(theta(1)+theta(2));
    J(1,2) = -l(2)*sin(theta(1)+theta(2));
    J(2,1) = l(1)*cos(theta(1)) + l(2)*cos(theta(1)+theta(2));
    J(2,2) = l(2)*cos(theta(1)+theta(2));
    
end

function J=fdJacob2D(l,theta,alpha)

    J1 = (evalRobot2D(l,theta+[alpha;0])-evalRobot2D(l,theta-[alpha;0]))/(2*alpha);
    J2 = (evalRobot2D(l,theta+[0;alpha])-evalRobot2D(l,theta-[0;alpha]))/(2*alpha);
    J = [J1 J2];   
end


function theta=invKin2D(l,theta0,pos,n,mode)

    if mode == 0 % Newton's Method 
       for i =1:n
           [posN,J] = evalRobot2D(l,theta0);
           
           f(1,1) = l(1)*cos(theta0(1))+l(2)*cos(theta0(1)+theta0(2))-pos(1);
           f(2,1) = l(1)*sin(theta0(1))+l(2)*sin(theta0(1)+theta0(2))-pos(2);
           s = -J\f;
           theta = theta0 + s; % update theta before possible break
           
           if abs(norm(posN-pos)) < 0.0001
              break;   
           end
           
           theta0 = theta;
        end
    end
    
    if mode == 1 % Broyden's method 
        [~, B] = evalRobot2D(l,theta0);
        for i = 1:n
           
            fk(1,1) = l(1)*cos(theta0(1))+l(2)*cos(theta0(1)+theta0(2))-pos(1);
            fk(2,1) = l(1)*sin(theta0(1))+l(2)*sin(theta0(1)+theta0(2))-pos(2);
            
            s = -B\fk;
            
            theta = theta0 + s;
            fkN(1,1) = l(1)*cos(theta(1))+l(2)*cos(theta(1)+theta(2))-pos(1);
            fkN(2,1) = l(1)*sin(theta(1))+l(2)*sin(theta(1)+theta(2))-pos(2);
            
            y = fkN - fk;
            
            B = B + ((y-B*s)*s')/(s'*s);
            
            [posN,~] = evalRobot2D(l,theta0);
            if abs(norm(posN-pos)) < 0.0001
                break;
            end
            
            theta0 = theta;
        end
    end

end



