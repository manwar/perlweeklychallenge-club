(import scheme
	(chicken base)
	srfi-1)

(define (distinct-digits? n)
  (let ((cs (string->list (number->string n))))
    (= (length cs)
       (length (delete-duplicates cs char=?)))))

(define (largest-interval n)
  (let loop ((nums (filter distinct-digits? (iota n 1)))
	     (jump 0))
    (if (or (null? nums) (null? (cdr nums)))
	jump
	(loop (cdr nums)
	      (max jump (- (cadr nums) (car nums)))))))

(begin
  (display (largest-interval 20)) (newline)
  (display (largest-interval 110)) (newline)
  (display (largest-interval 500)) (newline)
  (display (largest-interval 2026)) (newline)
  (display (largest-interval 10000)) (newline))

