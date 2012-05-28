function ret = img_to_blocks(M,n)
	width = size(M,2);
	height = size(M,1);
	s = ceil(width/n);
	blocks = s * ceil(height/n);
	ret = zeros(blocks, 3, n,n);
	for i = 1:height
		h = floor((i-1)/n);
		i2 = round(i-h*n);
		for j = 1:width
			w = floor((j-1)/n);
			block = round(w + h*s)+1;
			j2 = round(j-w*n);
			for k = 1:3
				if( width >= j && height >= i)
					ret(block, k, i2, j2) = M(i,j,k);
				else
					if( j > width)
						ret(block, k, i2, j2) = ret(block, k, i2 - 1, j2);
					endif
					if( i > height)
						ret(block, k, i2, j2) = ret(block, k, i2, j2 - 1);
					endif
					if( j > height && i > height)
						ret(block, k, i2, j2) = (ret(block, k, i2, j2 - 1) + ret(block, k, i2-1, j2))/2;
					endif
				endif
			end
		end
	end
endfunction