function ret = img_to_blocks(M,n)
	width = size(M,2);
	height = size(M,1);
	s = ceil(width/n);
	width2 = s*n;
	height2 = ceil(height/n) * n;
	blocks = s * ceil(height/n);
	ret = zeros(blocks, 3, n,n);
	for i = 1:height2
		h = floor((i-1)/n);
		i2 = round(i-h*n);
		for j = 1:width2
			w = floor((j-1)/n);
			block = round(w + h*s)+1;
			j2 = round(j-w*n);
			for k = 1:3
				if( width >= j && height >= i)
					ret(block, k, i2, j2) = M(i,j,k);
				else
					if( j > width)
						ret(block, k, i2, j2) = M(i,width,k);
					endif
					if( i > height)
						ret(block, k, i2, j2) = M(height,j,k);
					endif
					if( j > height && i > height)
						ret(block, k, i2, j2) = M(height,width,k);
					endif
				endif
			end
		end
	end
endfunction
