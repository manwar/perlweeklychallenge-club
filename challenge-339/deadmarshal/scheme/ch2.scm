(define (scanl f init xs)
  (let loop ((acc init)
	     (rest xs)
	     (result (list init)))
    (if (null? rest)
	(reverse result)
	(let ((next (f acc (car rest))))
	  (loop next (cdr rest) (cons next result))))))

(define (peak-point xs)
  (apply max (scanl + 0 xs)))

(begin
  (display (peak-point '(-5 1 5 -9 2))) (newline)
  (display (peak-point '(10 10 10 -25))) (newline)
  (display (peak-point '(3 -4 2 5 -6 1))) (newline)
  (display (peak-point '(-1 -2 -3 -4))) (newline)
  (display (peak-point '(-10 15 5))) (newline))

