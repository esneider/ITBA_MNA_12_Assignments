% I incidence matrix
function [M] = adj_matrix(I)

    M = double(I);
    N = length(I);

    for i=1:N
        s = sum(M(i, :));
        if s == 0
            s = N;
            M(i,:) = ones(1, N);
        endif
        M(i, :) ./= s;
    endfor

    M = transpose(M);
endfunction


% M modified adj_matrix
% d damping factor
function [M_hat] = super_M(M, d)

    N = length(M);
    M_hat = ones(N, N).*((1-d)/N) + M.*d;
endfunction


% A \  Ax=b
% b /
% error
function [x] =jacobi(A,b,error)
  n=length(A);
  D=diag(diag(A));
  L=D-tril(A);
  U=D-triu(A);
  invD=diag(1./diag(A));
  x=zeros(n,1);
  oldx=ones(n,1);
  while (max(abs(x-oldx)) > error)
      oldx=x;
      x=(invD*(L+U))*x+invD*b;
  endwhile
endfunction

% I incidence matrix
% d damping factor
% error
function [R] = solve_as_linear_system(I, d, error)

    N = length(I);
    A = eye(N) - d*adj_matrix(I);
    b = ((1-d)/N) .* ones(N, 1);
    R = jacobi(A, b, error);
    R ./= norm(R, 1);
endfunction


% I incidence matrix
% d damping factor
% error
function [R] = solve_with_power_method(I, d, error)

    N = length(I);

    R = rand(N, 1);
    R ./= norm(R, 2);
    old_R = ones(N, 1) * inf;

    M = super_M(adj_matrix(I), d);

    while(norm(R - old_R, 2) > error)
        old_R = R;
        R = M * R;
        R ./= norm(R, 2);
    endwhile

    R ./= norm(R, 1);
endfunction


%I = [
%      0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0;
%      0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0;
%      0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0;
%      1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0;
%      0, 1, 0, 1, 0, 1, 0, 0, 0, 0, 0;
%      0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0;
%      0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0;
%      0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0;
%      0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0;
%      0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0;
%      0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0
% ];

d = 0.85;

error = 1e-7;

max_links = 15;

LS = [];
PM = [];

N_range = 20:20:100
for N = N_range

    avg_links = rand() * max_links;

    I = rand(N)*N < avg_links;

    tic; solve_as_linear_system(I, d, error); LS = [LS, toc];
    tic; solve_with_power_method(I, d, error); PM = [PM, toc];

endfor

LS
PM

plot(N_range, LS);
plot(N_range, PM);
print -dpng bla.png;
