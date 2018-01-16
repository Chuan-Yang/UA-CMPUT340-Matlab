A = [1, 2, 3, 4, 0; 0, 0, 0, 2, 3; 0, 0, 0, 2, 1; 0, 0, 0, 0, 0; 0, 0, 0, 0, 0];
b = [1; 2; 3; 0; 0]; 

[L, U] = myLU(A);
L
U
y = fwdSubst(L,b,1);

x = backSubst(U,y);
x

function [M,L] = elimMat(A,k)

    [m,n] = size(A);

    M = eye(m,m);

    row = A(k,:);
    m = zeros(m);
    for j=k+1:numel(row)
       m(j) = row(j)/row(k);
    end

    L = M + m * M(k,1);
    M = M - m * M(k,1);


end


function [L,U]= myLU(A)

    L = eye(size(A)); U = eye(size(A));

    for k = 1:(size(A)-1)
        if A(k,k) == 0 %why
            break
        end
        [u,l] = elimMat(A,k);
        L = L*l;
        U = U*u;
        A = u*A;
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

function x = backSubst(U,b)

    [m,n] = size(b);
    x = zeros(m,1);

    for j=size(U):1
       if U(j,j) == 0
          break 
       end
       
       x(j,1) = b(j,1)/U(j,j);
       for i = 1:j-1
          b(i,1)=b(i,1) - U(i,j)*x(j,1); 
       end
    end

end














