clear all;

load light_pca

%-----------------------------------------------poly
[n,~] = size(Y);

X_new = linspace(X(1),X(),52);
for i = 1:n
    Y_new(i,:)=polynomial_interp(X,Y(i,:),X_new,7);
end

for i=1:n
    figure(i),plot(X,Y(i,:),'r.')
    hold on
    plot(X_new,Y_new(i,:))
    hold off    
end
pause();
close all;
for c = 1:size(Y_new,2)
  Ic = renderim(Y_new(:,c),B,imsize);
  imshow(Ic)
  drawnow
end
pause();
close all;
%----------------------------------------------Linear
for i = 1:n
    Y_new(i,:)=linear_interp(X,Y(i,:),X_new);
end

for i=1:n
    figure(i),plot(X,Y(i,:),'r.')
    hold on
    plot(X_new,Y_new(i,:))
    hold off    
end
pause();
close all;
for c = 1:size(Y_new,2)
  Ic = renderim(Y_new(:,c),B,imsize);
  imshow(Ic)
  drawnow
end
pause();
close all;

%-------------------------------------------------------------Part 5
Y1 = Y;

for i = 4:2:12
    Y1(i,:) = zeros(1, 13);
end

for i = 1:n
    Y_new(i,:)=linear_interp(X,Y1(i,:),X_new);
end
for c = 1:size(Y_new,2)
  Ic = renderim(Y_new(:,c),B,imsize);
  imshow(Ic)
  drawnow
end
pause();
close all;

%---------------------------------------------------------Part 6
X_omit = X(:,[1:7, 10:13]);
Y_omit = Y(:,[1:7, 10:13]);

Y_new=linear_interp(X_omit,Y_omit,X);

for i = 7:8
    subplot(1,2,1)
    
	Ic = renderim(Y(:,i),B,imsize);
	imshow(Ic)
	drawnow

 	subplot(1,2,2)
	Ic = renderim(Y_new(:,i),B,imsize);
    imshow(Ic)
    drawnow
    
    pause();
end




% Functions --------------------------------------------------
function Y_new=linear_interp(X,Y,X_new)
    Y_new=spline(X,Y,X_new);
end

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

