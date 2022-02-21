#!/usr/local/bin/guile
!#

;;;
;;; See https://theweeklychallenge.org/blog/perl-weekly-challenge-153
;;;

;;;
;;; Run as: guile --no-auto-compile ch-1.scm
;;;


(use-modules (ice-9 rdelim))

(define (fac n)
    (cond ((= n 0) 1)
          (else (* n (fac (- n 1))))))

(define (sum num)
    (cond ((= num 0) 0)
          (else (+ (fac (modulo num 10)) (sum (floor/ num 10))))))

(define (check num)
    (if (= num (sum num))
        (display "1\n")
        (display "0\n")))

(define (main)
    (define line (read-line))
    (if (not (eof-object? line))
        (begin
            (check (string->number line)) 
            (main))))

(main)
