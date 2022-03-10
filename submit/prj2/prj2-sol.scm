(define (int->unary n)
  (if (= 0 n)
    'z
   )  
  (if (> n 0)
    (cons 's (int->unary (- n 1)))
     'z)
)

(define (unary->int ls) 
	(cond 
		((eq? ls 'z ) 0) 
		(else (+ 1 (unary->int(cdr ls)))) 
	)
)

(define (unary-add m n) 
	(cond 
		((eq? m 'z) n) 
		(else (cons (car m) (unary-add (cdr m) n)))
  	)
)
