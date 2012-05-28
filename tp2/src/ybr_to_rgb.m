function ret = ybr_to_rgb(M)
	coef_matrix = [ 1, 0, 1.4020; 1, -0.34414, -0.71414; 1, 1.772, 0];
	ybr = zeros(3,1);
	ret = zeros(size(M));
	for i = 1:size(M,1)
		for j = 1:size(M,2)
			ybr(1) = M(i,j,1);
			ybr(2) = M(i,j,2) - 128;
			ybr(3) = M(i,j,3) - 128;
			aux = coef_matrix * ybr;
			for k = 1:3
				ret(i,j,k) = aux(k);
			end
		end
	end
endfunction