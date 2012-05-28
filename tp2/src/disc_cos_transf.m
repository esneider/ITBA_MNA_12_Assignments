function ret = disc_cos_transf(M, N)
	ret = zeros(N,N);
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
			sum = 0;
			for n = 1:N
				for m = 1:N
					sum = sum + a*b*M(n,m)*cos(pi*((n-1/2)*(l-1))/N)*cos(pi*((m-1/2)*(k-1))/N);
				end
			end
			sum = sum/N;
			ret(l,k) = sum;
		end
	end
endfunction