function ret = blocks_to_img(M, height, width)
	n = size(M,3);
	blocks = size(M,1);
	s = ceil(width/n);
	ret = zeros(height,width, 3);
	for i = 1:blocks
		aux = floor((i-1)/s);
		j2 = round(aux * n);
		k2 = round(((i-1) - aux*s)*n);
		for j = 1:n
			j3 = j + j2;
			for k = 1:n
				k3 = k +k2;
				if( j3 <= height && k3 <=width)
					for l = 1:3
						ret(j3,k3,l) = M(i,l,j,k);
					end
				endif
			end
		end
	end
	
endfunction