#lang racket
(require rackunit)

(define (max_dist x y)
(apply max
       (map (lambda (z) (apply max z))
            (for/list ([i  x])
              (for/list ([j (length y)])
                (abs (- i (list-ref y j)))
                )
              )
            )
       )
)

(max_dist '(4 5 7) '(9 1 3 4))
(check-equal? 6 (max_dist '(4 5 7) '(9 1 3 4)))

(max_dist '(2 3 5 4) '(3 2 5 5 8 7))
(check-equal? 6 (max_dist '(2 3 5 4) '(3 2 5 5 8 7)))

(max_dist '(2 1 11 3) '(2 5 10 2))
(check-equal? 9 (max_dist '(2 1 11 3) '(2 5 10 2)))

(max_dist '(1 2 3) '(3 2 1))
(check-equal? 2 (max_dist '(1 2 3) '(3 2 1)))

(max_dist '(1 0 2 3) '(5 0))
(check-equal? 5 (max_dist '(1 2 3) '(3 2 1)))
