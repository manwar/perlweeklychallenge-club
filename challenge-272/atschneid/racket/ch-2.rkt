#lang racket

(define inputs '("hello" "perl" "raku" "lisp" "scheme" "racket"))

(define (sum-abs-char-diffs s)
  (let* ([char-list (string->list s)] [num-list (map char->integer char-list)])
    (let loop ([num-list num-list] [diff-sum 0])
      (if (> 2 (length num-list))
          diff-sum
          (loop (cdr num-list) (+ diff-sum (abs (- (car num-list) (cadr num-list)))))))))

(let ([diffs (map sum-abs-char-diffs inputs)])
  (map (lambda [c n] (printf "~a : ~a\n" c n)) inputs diffs)
  #t)
