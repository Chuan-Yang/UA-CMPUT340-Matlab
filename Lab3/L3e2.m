clear all;

load sincos_basis

newB(:,1) = sin(2*asin(B(:,1)));
newB(:,2) = cos(2*acos(B(:,2)));
% ax = atan2(cos(ax), sin(ax)

newY(1,:) = cos(2*acos(Y(1,:)));
newY(2,:) = sin(2*asin(Y(2,:)));

for i = 1:64
    
    Ii = renderim(Y(:,i),B,imsize); 
    subplot(1,3,1);
    imshow(Ii,[]); 

    Ii = renderim(Y(:,i),newB,imsize); 
    subplot(1,3,2);
    imshow(Ii,[]); 
    
    Ii = renderim(newY(:,i),B,imsize); 
    subplot(1,3,3);
    imshow(Ii,[]); 
    
    drawnow; 
    pause(0.1);
    

end
