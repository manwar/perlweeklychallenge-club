#lang racket 

(define (binary-reflection xs)
  (define (string-reverse s)
    (list->string (reverse (string->list s)))) ;; so ugly
  (define (reflect x)
    (string->number (string-reverse (number->string x 2)) 2))

    (sort xs
    (lambda [x y]
      (let ([rx (reflect x)]
            [ry (reflect y)])
        (or (< rx ry)
            (< x y))))))

(require rackunit)
(check-equal? (binary-reflection '(3 6 12)) '(3 6 12))
(check-equal? (binary-reflection '(1 2 4 8)) '(1 2 4 8))
(check-equal? (binary-reflection '(7 8 9 10)) '(8 10 7 9))
(check-equal? (binary-reflection '(5 9 15 17)) '(5 9 15 17))
(check-equal? (binary-reflection '(11 13 14 19)) '(14 13 11 19))

;; Additional edge cases
(check-equal? (binary-reflection '()) '())
(check-equal? (binary-reflection '(1)) '(1))
(check-equal? (binary-reflection '(2 1)) '(1 2))
(check-equal? (binary-reflection '(10 2 8 1)) '(1 2 8 10))

