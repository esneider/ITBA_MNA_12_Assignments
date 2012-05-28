function ret = dequantify(M, alpha)
	Qy = [16 11 10 16 124 140 151 161;12 12 14 19 126 158 160 155;14 13 16 24 140 157 169 156;14 17 22 29 151 187 180 162;18 22 37 56 168 109 103 177;24 35 55 64 181 104 113 192;49 64 78 87 103 121 120 101;72 92 95 98 112 100 103 199];
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
						val = M(b,k,i,j)*Qy(i,j);
					else
						val = M(b,k,i,j)*Qc(i,j);
					endif
					if( val > 128)
						val = 128;
					endif
					if( val < -127)
						val = -127;
					endif
					ret(b,k,i,j) = val;
				end
			end
		end
	end

endfunction