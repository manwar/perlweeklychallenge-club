(define (calculate-gaps xs)
  (if (or (null? xs) (null? (cdr xs)))
      '()
      (cons (- (cadr xs) (car xs))
	    (calculate-gaps (cdr xs)))))

(define (find-min-gap-element xs)
  (let* ((gaps (calculate-gaps xs))
	 (min-gap (apply min gaps))
	 (index (list-index (lambda (x) (= x min-gap)) gaps)))
    (list-ref xs (+ index 1))))

(define (list-index pred lst)
  (let loop ((lst lst) (index 0))
    (cond
     ((null? lst) #f)
     ((pred (car lst)) index)
     (else (loop (cdr lst) (+ index 1))))))

(begin
  (display (find-min-gap-element '(2 8 10 11 15))) (newline)
  (display (find-min-gap-element '(1 5 6 7 14))) (newline)
  (display (find-min-gap-element '(8 20 25 28))) (newline))

