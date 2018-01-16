clear all;
m = 3;
X = 0:0.5:m*pi;
Y = sin(X);

for n = 1:11
    X_NEW = (0:0.1:2^(1/n)*m*pi);
    
    Y_new = polynomial_interp(X,Y,X_NEW,n);
    
    % Plot
    if length(X) > n+1
        y = polynomial_interp(X,Y,X,n);
        err1 = sqrt(sum((y-Y).^2)); 
        err2 = sqrt(sum((sin(X_NEW)-Y_new).^2));
        
        figure
        title({'For degree: ' num2str(n) 'The error between the interpolated y value and the ground-truth on X: ' num2str(err1) 'The error between the interpolated y and the ground-truth on X new: ' num2str(err2)});
        hold on;
        plot(X_NEW,Y_new,'-');
        plot(X_NEW,sin(X_NEW), ':');
        hold off;
    end
end

% Use monomial to set up the eqs.
function Y_new=polynomial_interp(X,Y,X_NEW,n)
    [~,a] = size(X);
    A = ones(a, n);
    for i = 1:n 
        A(:,i+1) =  (X').^i;
    end

    x = A\Y';
    
    [~,b] = size(X_NEW);
    Y_new = zeros(1, b);
    for i = 1:n+1 
        Y_new = Y_new + (X_NEW.^(i-1)) * x(i);
    end

end

