#!/usr/bin/env racket

#lang racket
(require rackunit)
(require racket/trace)  ;to trace function f add (trace f) after f defn

;;Given a non-negative int argument n, return its unary representation.
(define (int->unary n)
	(if (= 0 n) 'z (cons 's (int->unary (-n 1))))
)

(check-equal? (int->unary 0) 'z)
(check-equal? (int->unary 1) '(s . z))
(check-equal? (int->unary 2) '(s s . z))
(check-equal? (int->unary 5) '(s s s s s . z))

;;Given a valid unary representation of a natural number, return the 
;;corresponding scheme integer.
(define (unary->int n)
	(cond
		((eq? ls 'z) 0)
		(else (+ 1 (unary->int(cdr ls))))
	)	
)

(check-equal? (unary->int 'z) 0)
(check-equal? (unary->int '(s . z)) 1)
(check-equal? (unary->int  '(s  s . z)) 2)
(check-equal? (unary->int '(s s s s s . z)) 5)


;;Given two valid unary representations m and n, return the unary representation
;;of their sum.
(define (unary-add m n)
	(cond 
		((eq? m 'z) n)
		(else (cons (car m) (unary-add (cdr m) n)))
	)  
)

(check-equal? (unary-add 'z '(s . z)) '(s . z))
(check-equal? (unary-add '(s . z) 'z) '(s . z))
(check-equal? (unary-add '(s  s . z) '(s . z)) '(s s s . z))
(check-equal? (unary-add (int->unary 5) (int->unary 9)) (int->unary 14))

;;Instead of using successor on the result, we can use successor on
;;the 2nd argument to get this alternate function which has the
;;advantage that it is tail-recursive.
(define (aux-uatr m n s)
    (if (eq? m 'z)
        n
        (cons (car m) (aux-uatr (cdr m) n (+ 1 s))))
)
(define (unary-add-tr m n)
	(aux-uatr m n 0) 
)

(check-equal? (unary-add-tr 'z '(s . z)) '(s . z))
(check-equal? (unary-add-tr '(s . z) 'z) '(s . z))
(check-equal? (unary-add-tr '(s  s . z) '(s . z)) '(s s s . z))
(check-equal? (unary-add-tr (int->unary 5) (int->unary 9)) (int->unary 14))


;;Given two valid unary representations m and n, return the unary representation
;;of their product.
(define (mul-help m n s)
	(if (= (unary->int n) 1)
	s
	(mul-help m (cdr n) (unary-add m s))
	)
)
(define (unary-mul m n)
	(if (= (unary->int n) 0)
		'z (mul-help m n m)
	) 
)

(check-equal? (unary-mul 'z '(s . z)) 'z)
(check-equal? (unary-mul '(s s . z) 'z) 'z)
(check-equal? (unary-mul '(s . z) '(s . z)) '(s . z))
(check-equal? (unary-mul '(s s . z) '(s . z)) '(s s . z))
(check-equal? (unary-mul '(s s . z) '(s s  s . z))
	      '(s s s s s s . z))
(check-equal? (unary-mul (int->unary 5) (int->unary 9)) (int->unary 45))

;;Returns true iff proper-list ls contains only empty lists.
(define (contains-empty-lists-only? ls)
   (cond
   ((null? ls) #t)
   ((empty? ls) #t)
   ((empty? (car ls)) (contains-empty-list-only? (cdr ls)))
   (else #f)
   )
)

(check-equal? (contains-empty-lists-only? '()) #t)
(check-equal? (contains-empty-lists-only? '(())) #t)
(check-equal? (contains-empty-lists-only? '((()))) #f)
(check-equal? (contains-empty-lists-only? '(() ())) #t)
(check-equal? (contains-empty-lists-only? '(() () ())) #t)
(check-equal? (contains-empty-lists-only? '(1 () () ())) #f)

;;Given a non-empty proper list ls of proper sub-lists, return a pair.
;;The first element of the returned pair is a proper list containing
;;the first elements of each sub-list (if a sub-list is empty, the
;;corresponding element is returned as '()).  The second element of
;;the returned pair is a proper list containing the remaining elements
;;of each sub-list (again, if a sub-list is empty, then corresponding
;;element is returned a '()).  It follows that each element of the
;;returned pair will have length equal to that of ls.
(define (getHeads ls len)
  (if (null? ls) '()
    (if (null? (car ls)) '()
      (if (> 0 len)
        '()
        (cons (car (car ls)) (getHeads (cdr ls) (- len         1)))
        )
      )
    )
  )

(define (getTails ls len)
  (if (null? ls) '()
    (if (null? (car ls)) '()
    (if (> 0 len)'()
      (cons (cdr (car ls)) 
         (getTails (cdr ls) (- len 1)))
        )
       )
    )
  )  
(define (split-firsts ls (tuple '()) (rest '()))
	(cons (getHeads ls (length ls)) (getTails ls (length ls)))
)

(check-equal? (split-firsts '((a) ())) '( (a ()) .(() ()) ))
(check-equal? (split-firsts '((a) (1))) '( (a 1) . (() ()) ))
(check-equal? (split-firsts '((a b) (1 2))) '( (a 1) . ((b) (2) ) ))
(check-equal? (split-firsts '((a b c) (1 2 3))) '( (a 1) . ((b c) (2 3)) ))
(check-equal? (split-firsts '((a b c) (1))) '((a 1) . ( (b c) ()) ))
(check-equal? (split-firsts '((a) (1 2 3))) '( (a 1) . (() (2 3)) ))
(check-equal? (split-firsts '((a) (1 2 3) (x y z)))
	                    '( (a 1 x) . (() (2 3) (y z)) ))


;;Given a proper list of proper sub-lists ls, return a list of tuples
;;formed by picking a tuple element from each sub-list, picking '()
;;when a sub-list is exhausted.  The length of the returned list is
;;the length of the longest sub-list in ls and the # of elements in
;;each tuple is the length of ls.
(define (nth-tup ls len)
  (if (null? ls)
    '0
    (cons (car(split-firsts ls)    
  ) (nth-tup (cdr(split-firsts ls)) (- (length ls) 1)))
  )
)
(define (cleanup ls)
  (list ls)
)
(define (list-tuples ls) 
  (nth-tup ls (length ls))
)
(check-equal? (list-tuples '(() ())) '())
(check-equal? (list-tuples '((a) ())) '((a ())))
(check-equal? (list-tuples '((a) (1))) '((a 1)))
(check-equal? (list-tuples '((a b) (1 2))) '((a 1) (b 2)))
(check-equal? (list-tuples '((a b c) (1 2 3))) '((a 1) (b 2) (c 3)))
(check-equal? (list-tuples '((a b c) (1))) '((a 1) (b ()) (c ())))
(check-equal? (list-tuples '((a) (1 2 3))) '((a 1) (() 2) (() 3)))
(check-equal? (list-tuples '((a) (1 2 3) (x y))) '((a 1 x) (() 2 y) (() 3 ())))
