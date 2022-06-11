#!/usr/local/bin/guile
!#

;;;
;;; See https://theweeklychallenge.org/blog/perl-weekly-challenge-149
;;;

;;;
;;; Run as: guile --no-auto-compile ch-1.scm < input-file
;;;


(use-modules (ice-9 rdelim))
(use-modules (ice-9 format))

(define (digit_sum n)
    (define base 10)
    (if (= n 0) 0 (+ (modulo n base) (digit_sum (floor/ n base)))))

(define (_is_fib n prev last)
    (cond ((= n prev) #t)
          ((< n prev) #f)
          (else (_is_fib n last (+ last prev)))))

(define (is_fib n) (_is_fib n 0 1))

(define (digit_fib k n)
    (cond ((= n 0) #f)
          ((is_fib (digit_sum k)) 
             (begin (format #t "~d " k) (digit_fib (+ k 1) (- n 1))))
          (else (digit_fib (+ k 1) n))))


(define (main)
    (define n (read-line))
    (define k 0)
    (if (not (eof-object? n))
        (begin
            (digit_fib 0 (string->number n))
            (newline)
            (main))))

(main)
