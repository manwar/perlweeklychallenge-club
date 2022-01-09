#!/usr/local/bin/guile
!#

;;;
;;; See https://theweeklychallenge.org/blog/perl-weekly-challenge-003
;;;

;;;
;;; Run as: guile --no-auto-compile ch-2.scm
;;;


(use-modules (ice-9 rdelim))

(define (merge list1 list2)
    (if (> (length list1) 0)
        (append (list (+ (car list1) (car list2)))
                (merge   (cdr list1) (cdr list2)))
        '()))

(define (nextrow row)
    (merge (append (list 0) row) (append row (list 0))))

(define (show row)
    (cond ((= (length row) 0) (newline))
          (else (display (car row))
                (display " ")
                (show (cdr row)))))

(define (_pascal rows row)
    (if (>= rows 0)
        (begin
            (show row)
            (_pascal (- rows 1) (nextrow row)))))

(define (pascal rows)
    (_pascal rows (list 1))
)

(define (main)
    (define max (read-line))
    (if (not (eof-object? max))
        (begin
            (pascal (string->number max))
            (main)
        )
    )
)

(main)
