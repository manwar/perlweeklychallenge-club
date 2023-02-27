#lang racket/base

(require racket/list racket/match)
(define (solution nums)
  (for/fold ([num1 -1]
             [num2 -1]
             [max-xor 0])
            ([pair (in-combinations nums 2)])
    (match-let ([(list p1 p2) pair])
      (let ([xor (bitwise-xor p1 p2)])
        (if (> xor max-xor)
            (values p1 p2 xor)
            (values num1 num2 max-xor))))))

(define (demo n nums)
  (let-values ([(n1 n2 xor) (solution nums)])
    (printf "Example ~A: The maximum result of ~A xor ~A = ~A~%" n n1 n2 xor)))

(demo 1 '(1 2 3 4 5 6 7))
(demo 2 '(2 4 1 3))
(demo 3 '(10 5 7 12 8))
