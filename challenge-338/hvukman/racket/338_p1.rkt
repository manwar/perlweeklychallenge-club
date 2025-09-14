#lang racket

(require rackunit)
(require srfi/1) ; for fold

(define input '((4 4 4 4) (10 0 0 0)
  (2 2 2 9)))

(define input2 '((1 5) (7 3)
  (3 5) ))

(define input3 '((1 2 3) (3 2 1)
  ))

(define input4 '((2 8 7) (7 1 3) (1 9 5)
  ))

(define input5 '((10 20 30) (5 5 5) (0 100 0) (25 25 25)
  ))


(check-equal? '(16 10 6 17 100)
(for/list ( [i (list input input2 input3 input4 input5)]
            )
  (apply max (map (lambda (x) (fold + 0 x)) i))
  ))

(for/list ( [i (list input input2 input3 input4 input5)]
            )
  (apply max (map (lambda (x) (fold + 0 x)) i))
  )
  

