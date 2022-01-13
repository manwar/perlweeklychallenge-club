#!/usr/local/bin/guile
!#

;;;
;;; See https://theweeklychallenge.org/blog/perl-weekly-challenge-002
;;;

;;;
;;; Run as: guile --no-auto-compile ch-2.scm
;;;


(use-modules (ice-9 rdelim))

(define frombase #f)
(define   tobase #f)
(define     base 35)

(if (= (length (command-line)) 2)
    (cond ((string=? (list-ref (command-line) 1) "-f") (set! frombase #t))
          ((string=? (list-ref (command-line) 1) "-t") (set!   tobase #t)))
)

(define glyphs "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ")

(define (_to_base num base)
    (cond ((= num 0) "")
          (else (string-concatenate
                   (list (_to_base         (floor-quotient num base) base)
                         (substring glyphs (modulo         num base)
                                      (+ 1 (modulo         num base))))))))
(define (to_base num base)
    (cond ((= num 0) "0")
          (else (_to_base num base))))


(define (from_base num base)
    (define len (string-length num))
    (cond ((= len 0) 0)
          (else (+ (string-contains glyphs (string-take-right num 1))
                   (* base (from_base      (string-drop-right num 1) base))))))


(define (main)
    (define line (read-line))
    (if (not (eof-object? line))
        (begin
            (if   tobase (display (  to_base (string->number line) base)))
            (if frombase (display (from_base                 line  base)))
            (newline)
            (main)
        )
    )
)

(main)
