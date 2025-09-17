(define (max-diff xs)
  (let* ((s (sort < xs))
	 (n (length xs))
	 (e (* (list-ref s (sub1 n))
	       (list-ref s (- n 2))))
	 (f (* (car s)
	       (list-ref s 1))))
    (- e f)))

(begin
  (display (max-diff '(5 9 3 4 6))) (newline)
  (display (max-diff '(1 -2 3 -4))) (newline)
  (display (max-diff '(-3 -1 -2 -4))) (newline)
  (display (max-diff '(10 2 0 5 1))) (newline)
  (display (max-diff '(7 8 9 10 10))) (newline))

