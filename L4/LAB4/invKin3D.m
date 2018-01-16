function theta=invKin3D(M,theta,pos)
    theta0 = theta;
    n = 10000;
    for i = 1:n
        [new_pos, Jacobian] = evalRobot3D(M, theta);
        fx = new_pos - pos;
        s = (Jacobian\-fx);
        theta = theta0 + s;
        differ = norm(new_pos-pos);
        if abs(differ) < 0.0000001
            break;
        end
        theta0 = theta;
    end
end

