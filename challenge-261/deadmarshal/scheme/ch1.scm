(define (number->list num)
  (let loop ((num num)
	     (acc '()))
    (if (< num 10)
	(cons num acc)
	(loop (quotient num 10)
	      (cons (remainder num 10) acc)))))

(define (flatten xs)
  (cond ((null? xs) '())
	((pair? xs) (append (flatten (car xs)) (flatten (cdr xs))))
	(else (list xs))))

(define (element-digit-sum list)
  (abs (- (apply + (flatten (map number->list list)))
	  (apply + list))))

(begin
  (display (element-digit-sum '(1 2 3 45))) (newline)
  (display (element-digit-sum '(1 12 3))) (newline)
  (display (element-digit-sum '(1 2 3 4))) (newline)
  (display (element-digit-sum '(236 416 336 350))) (newline))

