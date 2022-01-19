#!/usr/local/bin/guile
!#

;;;
;;; See https://theweeklychallenge.org/blog/perl-weekly-challenge-003
;;;

;;;
;;; Run as: guile --no-auto-compile ch-1.scm
;;;


(use-modules (ice-9 rdelim))


(define (ugly uglylist mx next_2 next_3 next_5)
    (define mymin)
    (cond ((= mx (length uglylist)) (list-ref uglylist (- mx 1)))
          (else
              (set! mymin (min (* 2 (list-ref uglylist next_2))
                               (* 3 (list-ref uglylist next_3))
                               (* 5 (list-ref uglylist next_5))))

              (ugly (append uglylist (list mymin) )
                     mx
                    (if (<= (* 2 (list-ref uglylist next_2)) mymin)
                                       (+ next_2 1) next_2)
                    (if (<= (* 3 (list-ref uglylist next_3)) mymin)
                                       (+ next_3 1) next_3)
                    (if (<= (* 5 (list-ref uglylist next_5)) mymin)
                                       (+ next_5 1) next_5)))))

(define (main)
    (define mx (read-line))
    (if (not (eof-object? mx))
        (begin
            (display (ugly (list 1) (string->number mx) 0 0 0))(newline)
            (main)
        )
    )
)

(main)
