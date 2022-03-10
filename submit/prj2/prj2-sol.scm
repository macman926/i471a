
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

(define (unary-add-tr m n) 
	(cond 
		((eq? m 'z) n) 
		(else (cons (car m) (unary-add (cdr m) n))) 
	) 
)

(define (int->unary n) 
	(if (= 0 n) 'z (cons 's (int->unary (- n 1))))
)
