function ret = calc_zeros(B)
	blocks = size(B,1);
	ret = 0;
	N = size(B,3);
	for b = 1:blocks
		for k = 1:3
			for i = 1:N
				for j = 1:N
					if(B(b,k,i,j) == 0)
						ret = ret+1;
					endif
				end
			end
		end
	end
	ret = ret / (blocks * N * N * 3);
endfunction