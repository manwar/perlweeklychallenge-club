#lang racket

(require racket/file)
(require srfi/1)
(require rackunit)

(define (remove-nth lst n)
  (let loop ([i 0] [lst lst])
    (cond [(= i n) (rest lst)]
          [else (cons (first lst) (loop (add1 i) (rest lst)))])))

(define (dummy x y) (filter (lambda (z) (>= x z)) y) 
  )

(define (Smaller x)
(for/list ( [i (iota (length x) )] )
  (let ([y (list-ref x i)])
     (length (dummy y (remove-nth x i)))
    )
  )
  )

(check-equal? '((2 1 0 3) (3 3 3 3) (4 3 2 1 0) (1 2 4 0 3) (1 3 3 4 1))
              (map Smaller '( (6 5 4 8) (7 7 7 7) (5 4 3 2 1) (-1 0 3 -2 1) (0 1 1 2 0))))

(map Smaller '( (6 5 4 8) (7 7 7 7) (5 4 3 2 1) (-1 0 3 -2 1) (0 1 1 2 0)))

