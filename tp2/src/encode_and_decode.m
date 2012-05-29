function encode_and_decode(inimg, outimg, diffimg, alpha)
	%First we encode...
	I = imread(inimg);
	B = rgb_to_ybr(I);
	B = img_to_blocks(B,8);
	aux = zeros(8,8);
	for b = 1:size(B,1)
		for k = 1:3
			
			for i = 1:8
				for j = 1:8
					aux(i,j) = B(b,k,i,j) - 128;
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
	B = quantify(B,alpha);
	%Done encoding! Calculate stuff here...
	zeros = calc_zeros(B)
	%Now decode
	B = dequantify(B,alpha);
	for b = 1:size(B,1)
		for k = 1:3
			for i = 1:8
				for j = 1:8
					aux(i,j) = B(b,k,i,j);
				end
			end
			aux = disc_cos_antitransf(aux, 8);
			for i = 1:size(aux,1)
				for j = 1:size(aux,2)
					B(b,k,i,j) = round(aux(i,j) + 128);
				end
			end
		end
	end
	%zeros = calc_zeros(B)
	B = blocks_to_img(B, size(I,1), size(I,2));
	B = ybr_to_rgb(B);
	B = uint8(B);
	mean_square_error = calc_error(I-B)
	imwrite(B,outimg);
	imwrite(abs(I-B), diffimg);
endfunction