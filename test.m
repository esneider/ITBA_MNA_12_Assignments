% I incidence matrix
function [M] = adj_matrix(I)

    M = I
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
    M_hat = ones(N, N).*((1-d)/N) + M.*d;
endfunction


% I incidence matrix
% d damping factor
function [R] = solve_as_linear_system(I, d)

    R = super_M(adj_matrix(I), d) \ zeros(length(I));
enfunction


% I incidence matrix
% d damping factor
% error
function [R] = solve_with_power_method(I, d, error)

    R = rand(length(I), 1);
    R ./= norm(R, 2);
    old_R = ones(N, 1) * inf;

    M = super_M(adj_matrix(I), d);

    while(norm(R - old_R, 2) > error)
        old_R = R;
        R = M * R;
        R ./= norm(R, 2);
    endwhile
endfunction


I =
[
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

solve_as_linear_system(I, d)

solve_with_power_method(I, d, error)

