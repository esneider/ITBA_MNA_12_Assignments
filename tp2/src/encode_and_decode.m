function encode_and_decode(inimg, outimg, alpha)
	%First we encode...
	I = imread(inimg);
	B = rgb_to_ybr(I);
	B = img_to_blocks(B,8);
	for b = 1:size(B,1)
		for k = 1:3
			aux = zeros(8,8);
			for i = 1:8
				for j = 1:8
					aux(i,j) = B(b,k,i,j);
				end
			end
			aux = disc_cos_transf(aux, 8);
			for i = 1:8
				for j = 1:8
					B(b,k,i,j) = aux(i,j);
				end
			end
		end
	end
	B = quantify(B,1);
	%Done encoding! Calculate stuff here...
	
	%Now decode
	B = dequantify(B,1);
	for b = 1:size(B,1)
		for k = 1:3
			aux = zeros(8,8);
			for i = 1:8
				for j = 1:8
					aux(i,j) = B(b,k,i,j);
				end
			end
			aux = disc_cos_antitransf(aux, 8);
			for i = 1:size(aux,1)
				for j = 1:size(aux,2)
					B(b,k,i,j) = aux(i,j) + 128;
				end
			end
		end
	end
	B = blocks_to_img(B, size(I,1), size(I,2));
	B = ybr_to_rgb(B);
	imwrite(outimg, B);
	
	
	
	
endfunction