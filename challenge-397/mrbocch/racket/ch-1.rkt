#lang racket 

(define (absent-smallest-positive xs)
  (let* ([avg (quotient (foldl + 0 xs) (length xs))]
         [start (add1 (max 0 avg))]
         [end (+ 2 (apply max xs))]
         [rang (range start end)])
    (apply min (set-subtract rang xs))))

(require rackunit)

(check-equal? (absent-smallest-positive '(1 2 4 5 6)) 7)
(check-equal? (absent-smallest-positive '(-5 -2 -1 3)) 1)
(check-equal? (absent-smallest-positive '(1 2 3)) 4)
(check-equal? (absent-smallest-positive '(2 3 7 8)) 6)
(check-equal? (absent-smallest-positive '(1 1 1 10)) 4)
