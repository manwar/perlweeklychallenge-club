#lang racket

(define inputs '("1.1.1.1" "255.101.1.0"))

(define (defang-list s)
  (let loop ([s s])
    (if (empty? s)
        '()
        (let ([first (car s)] [rest (cdr s)])
          (case first
            [(#\.) (append '(#\[ #\. #\]) (loop rest))]
            [else (cons first (loop rest))])))))

(define (defang s)
  (list->string (defang-list (string->list s))))

(let ([defanged (map defang inputs)])
  (map (lambda [c n] (printf "~a => ~a\n" c n)) inputs defanged)
  #t)

