% Example 2.13
A=[1 2 2; 4 4 2; 4 6 4];
b=[3;6;10];

% Factorization
[L, U] = myLU(A);
display(L);
display(U);

% fwdSubst to solve for y
y = fwdSubst(L,b,1);
display(y);

% backSubst to solve for x
x = backSubst(U,y);
display(x);


% My own test

A=[1 3 6; 2 4 6; 3 4 5];
b=[9;10;12];

% Factorization
[L, U] = myLU(A);
display(L);
display(U);

% fwdSubst to solve for y
y = fwdSubst(L,b,1);
display(y);

% backSubst to solve for x
x = backSubst(U,y);
display(x);


function [M,L] = elimMat(A,k)

    [m,~] = size(A);

    M = eye(m); % also used as the identity matrix

    col = A(:,k);
    m = zeros(m,1);
    for j=k+1:numel(col)
       m(j) = col(j)/col(k);
    end

    e = M(:,k);
    L = M + m * (e');
    M = M - m * (e');


end


function [L,U]= myLU(A)

    [~, n] = size(A);
    L = eye(n); U = A;

    for k = 1:(n-1)
        if A(k,k) == 0 %why
            break
        end
        [M,l] = elimMat(A,k);
        L = L*l;
        U = M*U;
        A = M*A;
    end

end

function y = fwdSubst(L,b,k)

  [m,n]=size(L);
  if ~exist('k')  % If first call no k param given, but k=1
    k=1;
  end
  
  y=b(k)/L(k,k);
  if k < n % Recursion step
    l = [zeros(k,1);L(k+1:m,k)];
    y = [y;fwdSubst(L,b-y*l,k+1)];
  end
end

function x = backSubst(U,y,k)

    [m,~]=size(U);
    if ~exist('k')  % If first call no k param given, but k=1
        k=m;
    end
  
    x=y(k)/U(k,k);
    if k > 1 % Recursion step
        l = [U(1:k-1,k);zeros(m-k+1,1)];
        x = [backSubst(U,y-x*l,k-1);x];
    end
end














