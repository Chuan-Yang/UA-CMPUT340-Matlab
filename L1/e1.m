% Vectorize the following
% Note the use of the tic/toc calls to time execution
% Compare the time once you have vectorized it

tic
for i = 1:1000
    t(i) = 2*i;
    y(i) = sin (t(i));
end

toc

tic

t = [1:1000];
t = t*2;
y = sin(t);
%disp(y);

toc

clear;
