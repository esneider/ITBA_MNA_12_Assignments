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
function [x] = jacobi(A, b, error)

  N = length(A);
  D = diag(diag(A));
  L = D - tril(A);
  U = D - triu(A);
  invD = diag(1./diag(A));

  x = zeros(N, 1);
  oldx = ones(N, 1);

  while (max(abs(x - oldx)) > error)
      oldx = x;
      x = (invD*(L + U))*x + invD*b;
  endwhile
endfunction

function [x] = octave_solve(A, b, error)

    x = A \ b;
endfunction

% I incidence matrix
% d damping factor
% error
function [R] = solve_as_linear_system(I, d, error, jacob)

    N = length(I);
    A = eye(N) - d*adj_matrix(I);
    b = ((1-d)/N) .* ones(N, 1);

    if (jacob == 0)
        R = octave_solve(A, b, error);
    else
        R = jacobi(A, b, error);
    endif

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

max_links = 20;

LS = [];
PM = [];

N_range = 20:20:1000
for N = N_range

    avg_links = rand() * max_links;

    I = rand(N)*N < avg_links;

    tic; solve_as_linear_system(I, d, error, 1); LS = [LS, toc];
    tic; solve_with_power_method(I, d, error); PM = [PM, toc];

endfor

LS
PM

hold on;
plot(N_range, LS, "1;Sistema Lineal (jacobi);");
hold on;
plot(N_range, PM, "2;Método de las potencias;");
xlabel("Tamaño de la matriz");
ylabel("Segundos");
hold off;
replot();
print -dpng jacobi_pm.png;
hold off;
clearplot();

%%%%%%%%%%%%%%%

LS = [];
PM = [];

for N = N_range

    avg_links = rand() * max_links;

    I = rand(N)*N < avg_links;

    tic; solve_as_linear_system(I, d, error, 0); LS = [LS, toc];
    tic; solve_with_power_method(I, d, error); PM = [PM, toc];

endfor

LS
PM

hold on;
plot(N_range, LS, "1;Sistema Lineal (octave);");
hold on;
plot(N_range, PM, "2;Método de las potencias;");
xlabel("Tamaño de la matriz");
ylabel("Segundos");
hold off;
replot();
print -dpng octave_pm.png;
hold off;
clearplot();

%%%%%%%%%%%%%%%%

LS = [];
LSj = [];
PM = [];

for N = N_range

    avg_links = rand() * max_links;

    I = rand(N)*N < avg_links;

    tic; solve_as_linear_system(I, d, error, 0); LS = [LS, toc];
    tic; solve_as_linear_system(I, d, error, 1); LSj = [LSj, toc];
    tic; solve_with_power_method(I, d, error); PM = [PM, toc];

endfor

LS
LSj
PM

hold on;
plot(N_range, LS, "1;Sistema Lineal (octave);");
hold on;
plot(N_range, LSj, "3;Sistema Lineal (jacobi);");
hold on;
plot(N_range, PM, "2;Método de las potencias;");
xlabel("Tamaño de la matriz");
ylabel("Segundos");
hold off;
replot();
print -dpng octave_jacobi_pm.png;
hold off;
clearplot();

%%%%%%%%%%%%%

PM = []

N = 1000
avg_links = rand() * max_links;
I = rand(N)*N < avg_links;
d_range = 0.3:0.1:0.9

for d = d_range
    tic; solve_with_power_method(I, d, error); PM = [PM, toc];
endfor

PM

hold on;
plot(d_range, PM, ";Método de las potencias;");
xlabel("Factor de amortiguamiento");
ylabel("Segundos");
replot();
print -dpng d_pm.png;
hold off;
clearplot();

