function ret = rgb_to_ybr(M)
	coef_matrix = [ 0.2990, 0.5870, 0.1440; -0.1687, -0.3313, 0.5; 0.5, -0.4187, -0.0813];
	sum_matrix = [0;128;128];
	rgb = zeros(3,1);
	ret = zeros(size(M));
	for i = 1:size(M,1)
		for j = 1:size(M,2)
			for k = 1:3
				rgb(k) = M(i,j,k);
			end
			aux = coef_matrix * rgb + sum_matrix;
			for k = 1:3
				ret(i,j,k) = aux(k);
			end
		end
	end
endfunction