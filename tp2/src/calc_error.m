function ret = calc_error(M)
	M = uint32(M);
	height = size(M,1);
	width = size(M,2);
	ret = 0;
	for i = 1:height
		for j = 1:width
			for k = 1:3
				ret = ret + (M(i,j,k) * M(i,j,k));
			end
		end
	end
	ret = ret / (height * width * 3);
endfunction