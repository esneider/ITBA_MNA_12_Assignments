% I incidence matrix
function [M] = adj_matrix(I)

    M = I;
    N = length(I);

    for i=1:N
        s = sum(M(i, :));
        if s == 0
            s = N;
            M(i,:) = ones(1, N);
        endif
        M(i, :) ./= s;
    endfor
endfunction


% M modified adj_matrix
% d damping factor
function [M_hat] = super_M(M, d)

    N = length(M);
    M_hat = transpose(ones(N, N).*((1-d)/N) + M.*d);
endfunction


% I incidence matrix
% d damping factor
function [R] = solve_as_linear_system(I, d)

    N = length(I);
    R = (eye(N) - d*super_M(adj_matrix(I), d)) \ (((1-d)/N) .* ones(N, 1));
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


I = [
      0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0;
      0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0;
      0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0;
      1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0;
      0, 1, 0, 1, 0, 1, 0, 0, 0, 0, 0;
      0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0;
      0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0;
      0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0;
      0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0;
      0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0;
      0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0
 ];

d = 0.85;

error = 1e-3;

LS = solve_as_linear_system(I, d)
PM = solve_with_power_method(I, d, error)

