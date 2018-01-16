clear all;

load immotion_basis.mat

for i=1:13
    Ii = renderim(Y(:,i),B,imsize); 
    imshow(Ii,[]);
    drawnow; 
    pause(0.1);
end

I = imread('PP.jpg');
I = double(rgb2gray(I));
imsize = size(I);

[Ix, Iy] = gradient(I);
I = I(:);
Ix = Ix(:);
Iy = Iy(:);

for i=1:13
    Ii = renderim(Y(:,i),[I Ix Iy],imsize); 
    imshow(Ii,[]);
    drawnow; 
    pause(0.1);
end

newY = [1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1;
        0 5 6 7 8 9 10 0 0 0 0 0 0 5 6 7 8 9 10;
        0 0 0 0 0 0 0 5 6 7 8 9 10 5 6 7 8 9 10];
    
for i=1:13
    Ii = renderim(newY(:,i),[I Ix Iy],imsize); 
    imshow(Ii,[]);
    drawnow; 
    pause(0.1);
end






