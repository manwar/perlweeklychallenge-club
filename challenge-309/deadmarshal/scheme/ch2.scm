(define (pairs lst)
  (if (or (null? lst) (null? (cdr lst)))
      '()
      (cons (list (car lst) (cadr lst))
	    (pairs (cdr lst)))))

(define (min-diff lst)
  (let* ((sorted (sort < lst))
	 (diffs (map (lambda (p) (abs (- (car p) (cadr p))))
		     (pairs sorted))))
    (apply min diffs)))

(begin
  (display (min-diff '(1 5 8 9))) (newline)
  (display (min-diff '(9 4 1 7))) (newline))

