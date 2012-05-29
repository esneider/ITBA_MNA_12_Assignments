function ret = dequantify(M, alpha)
	Qy = [16 11 10 16 24 40 151 61;
	12 12 14 19 26 58 60 55;
	14 13 16 24 40 57 69 56;
	14 17 22 29 51 87 80 62;
	18 22 37 56 68 109 103 77;
	24 35 55 64 81 104 113 92;
	49 64 78 87 103 121 120 101;
	72 92 95 98 112 100 103 99];
	Qc = [17 18 24 47 99 99 99 99;18 21 26 66 99 99 99 99;24 26 56 99 99 99 99 99;47 66 99 99 99 99 99 99;99 99 99 99 99 99 99 99;99 99 99 99 99 99 99 99;99 99 99 99 99 99 99 99;99 99 99 99 99 99 99 99];
	Qy = Qy .* alpha;
	Qc = Qc .* alpha;
	blocks = size(M,1);
	N = size(M,3);
	ret = zeros(blocks, 3, N,N);
	for b = 1:blocks
		for k = 1:3
			for i = 1:N
				for j = 1:N
					if(k == 1)
						val = round(M(b,k,i,j)*Qy(i,j));
					else
						val = round(M(b,k,i,j)*Qc(i,j));
					endif
					ret(b,k,i,j) = val;
				end
			end
		end
	end

endfunction