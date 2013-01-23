function ret = disc_cos_antitransf(M, N)
	ret = zeros(N,N);
	for n = 1:N
		for m = 1:N
			sum = 0;
			for l = 1:N
				if(l == 1)
					a = 1;
				else
					a = sqrt(2);
				endif
				for k = 1:N
					if(k == 1)
						b = 1;
					else
						b = sqrt(2);
					endif
					sum = sum + a*b*M(l,k)*cos(pi*((n-1/2)*(l-1))/N)*cos(pi*((m-1/2)*(k-1))/N);
				end
			end
			sum = sum/N;
			ret(n,m) = sum;
		end
	end
endfunction