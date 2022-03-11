quadratic_roots(A,B,C,Z) :-
	X1 = ((-B + sqrt(B**2-4*(A*C)))/ 2*A),
        X2 = ((-B - sqrt(B**2-4*(A*C)))/ 2*A),
	Z is x1,
	Z is x2. 

	
