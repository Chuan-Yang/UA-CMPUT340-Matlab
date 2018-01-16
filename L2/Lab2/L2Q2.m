clear all;

I = imread('tumorContour.jpg'); 
[Init_x,Init_y]= find(I > 250);

brain = imread('tumor.jpg');

figure,imagesc(brain),colormap(gray),axis image,hold on
[x,y] = ginput(29);
% make it a circle to add the accuracy
x(30) = x(1); y(30) = y(1);
plot(x,y,'.r');
xb = [];
yb = [];

s_points = [1];
if x(1) > x(2)
    endp = false;
else
    endp = true;
end

% get the start points for each piece
for i = 1:29
    if endp
        if x(i+1) < x(i)
            s_points = [s_points i];
            endp = false;
        end
        
    else
        if x(i+1) > x(i)
            s_points = [s_points i];
            endp = true;
        end
    end
end

s_points = unique([s_points 30]);
pcs = length(s_points) - 1;
[totalN, ~] = size(Init_x);

%fit each piece
for i = 1:pcs
    
    xp = linspace(x(s_points(i)), x(s_points(i+1)), totalN/pcs);
    xb = [xb xp];
    
    %sorted and unique X linespace
    [C,ia,~] = unique(x(s_points(i):s_points(i+1)));
    a = y(s_points(i):s_points(i+1));
    yp = spline(C, a(ia),xp);
    yb = [yb yp];
end


plot(xb,yb,'b');
hold off

pause;


% still not fixed calculating the least square error
hold on 
imshow(I);

[xx, ia, ~] = unique(Init_y);
yy = Init_x(ia);
p = spline(xx,yy);
yt = ppval(p,xb);
lqe = sqrt(sum((yt-yb).^2));

title(['The Least Square Error is: ' num2str(lqe)]);

plot(x,y,'.r');
plot(xb,yb,'b');
hold off


