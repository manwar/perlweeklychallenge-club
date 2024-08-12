#lang typed/racket

(: key->idx (-> String (Listof Integer)))
(define (key->idx k)
  (let* ([cr (string->list k)]
         [col : Integer (- (char->integer (car cr)) (char->integer #\a))]
         [row : Integer (- (char->integer (car (cdr cr))) (char->integer #\1))])
    (list col row)))

(: check-color (-> String Boolean))
(define (check-color key)
  (let ([idxs (key->idx key)])
    (equal? (modulo (apply + idxs) 2) 1)))

(let loop ([inputs '("d3" "g5" "e6")])
  (if (null? inputs)
      #t
      (begin
        (printf "~a => ~a~n" (car inputs) (check-color (car inputs)))
        (loop (cdr inputs)))))