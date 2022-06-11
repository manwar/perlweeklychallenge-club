#!/usr/local/bin/guile
!#

;;;
;;; See https://theweeklychallenge.org/blog/perl-weekly-challenge-153
;;;

;;;
;;; Run as: guile --no-auto-compile ch-1.scm
;;;


(use-modules (ice-9 rdelim))

(define (main max sum fac n)
    (if (> max 0)
        (begin
            (display sum)
            (display " ")
            (main (- max 1) (+ sum (* n fac)) (* fac n) (+ n 1)))))

(main 10 1 1 1)
(newline)
