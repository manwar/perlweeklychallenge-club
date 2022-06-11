#!/usr/local/bin/guile
!#

;;;
;;; See https://theweeklychallenge.org/blog/perl-weekly-challenge-150
;;;

;;;
;;; Run as: guile --no-auto-compile ch-1.scm < input-file
;;;


(use-modules (ice-9 rdelim))
(use-modules (ice-9 format))

(define (fib fib_prev fib_last)
    (if (>= (string-length fib_last) 51)
        (format #t "~c\n" (string-ref fib_last 50))
        (fib fib_last (string-concatenate (list fib_prev fib_last)))))


(define (main)
    (define line (read-line))
    (if (not (eof-object? line))
        (begin
            (fib (list-ref (string-split line #\ ) 0)
                 (list-ref (string-split line #\ ) 1))
            (main)
        )
    )
)

(main)
