#!/usr/local/bin/guile
!#

;;;
;;; See https://theweeklychallenge.org/blog/perl-weekly-challenge-150
;;;

;;;
;;; Run as: guile --no-auto-compile ch-2.scm
;;;


(use-modules (ice-9 rdelim))
(use-modules (ice-9 format))

(define primes (list 2 3 5 7 11 13 17 19))

(define (square-free n primes)
    (cond ((null? primes) #t)
          ((= (modulo n (* (car primes) (car primes))) 0) #f)
          (else (square-free n (cdr primes)))))

(define (all-square-free from to)
    (if (<= from to)
        (begin
            (if (square-free from primes)
                (format #t "~d " from))
            (all-square-free (+ from 1) to))))

(all-square-free 1 500)
(newline)
