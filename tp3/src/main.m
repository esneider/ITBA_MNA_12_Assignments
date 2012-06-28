function main( dr, dt, max_time) 
	%Inicializo la matriz de temperaturas y vector de deformaciones
	T = ceil(max_time/dt) ;
	R = ceil(0.5/dr) + 1;
	U = zeros(R,T);
	
	%Se llenan las condiciones de contorno
	for t = 1:T
		if( (t-1) * dt <= 10)
			U(1, t) = (t-1) * dt;
			U(R, t) = 100 + 40*dt*(t-1);
		else
			U(1, t) = 10;
			U(R, t) = 500;
		endif
	end
	
	%Condiciones iniciales
	for r = 1:R
		U(r, 1) = 200* ((r-1)*dr);
	end
	
	%Variables datos
	K = 0.1;
	a = 10.7;
	
	%Variables de la ecaucion en diferencias
	p = dt * 4 * K / (dr*dr);
	
	%Se llena la matriz con el resto de los valores utilizando al regla en diferencias
	for t = 1:T-1
		for r = 2: R-1
			q = dr/((r-1)*dr + 0.5);
			U(r,t+1) = p*(1+q)*U(r+1,t) + (1-p*(2+q))*U(r,t) + p*U(r-1,t);
		end
	end
	
	%Se calculan las deformaciones con la regla del trapecio
	for t = 1:T
		D(t) = 0;
		for r = 1:R-1
			D(t) += a * (U(r,t)*((r-1)*dr + 0.5) + U(r+1,t)*(r*dr + 0.5) )/2 * dr;
		end
	end
	
	%plot de la deformacion
	plot((0:T-1) * dt, D);
	
	clearplot;
	hold on;
	
	%plot de las isotermas
	for temp = 1:8
		k = 1;
		clear ts;
		clear rs;
		for t = 1:T
			for r = 1: R
				if( abs(U(r,t) - temp*50) < 0.5)
					ts(k)  = (t-1) * dt;
					rs(k) = (r-1) * dr + 0.5;
					k +=1;
				endif
			end
		end
		plot(ts, rs);
	end
	hold off;
	print('isotemps.png');
	
	%Se plotea para r = 0.6, 0.7, 0.8, 0.9
	plot((0:T-1) .* dt, U(ceil(0.1/dr), :), (0:T-1) .* dt, U(ceil(0.2/dr), :), 
	(0:T-1) .* dt, U(ceil(0.3/dr), :), (0:T-1) .* dt, U(ceil(0.4/dr), :)); 
	
	
	
	
	
	%Realizar el mesh
	mesh((0:T-1) .* dt,(0:R-1) .* dr +0.5, U);
	
endfunction
	
	