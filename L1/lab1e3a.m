% Get the matrix A by the graph
A=[[0 0 0  0 0 0  1 1 1 ];[0 0 0  1 1 1  0 0 0 ];[1 1 1  0 0 0  0 0 0 ];

[0 0 0  0 0 1  0 1 1];[0 0 1  0 1 0  1 0 0];[1 1 0  1 0 0  0 0 0];

[0 0 1  0 0 1  0 0 1];[0 1 0  0 1 0  0 1 0];[1 0 0  1 0 0  1 0 0];

[0 1 1  0 0 1  0 0 0];[1 0 0  0 1 0  0 0 1];[0 0 0  1 0 0  1 1 0];];

% Original b
b = [13.00;15.00;8.00;14.79;14.31;3.81;18.00;12.00;6.00;10.51;16.13;7.04];

% Selected b (removed 2 5 11)
b_s = [13.00;8.00;14.79;3.81;18.00;12.00;6.00;10.51;7.04];

% Corresponding subset of A
A_s = [A(1,:);A(3:4,:);A(6:10,:);A(12,:);];

[L,U] = lu(A_s);

result_s = reshape(U\(L\b_s),[3 3]); % the result got by '\' is one col
result_s = result_s';
display(result_s);

% Solve the overdetermined system
result=reshape(A\b,[3 3]);
result=result';
display(result);





