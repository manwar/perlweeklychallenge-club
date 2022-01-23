#!/usr/local/bin/guile
!#

;;;
;;; See https://theweeklychallenge.org/blog/perl-weekly-challenge-148
;;;

;;;
;;; Run as: guile --no-auto-compile ch-1.scm
;;;

(use-modules (ice-9 regex))
(use-modules (ice-9 format))

(define pat "^0$|[1789]|^2.|[35]$")

(do ((i 0 (1+ i)))
    ((> i 100))
    (if (not (string-match pat (number->string i)))
        (format #t "~d " i)))

(newline)
