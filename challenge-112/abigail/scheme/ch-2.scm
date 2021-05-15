;;;
;;; See ../README.md
;;;

;;;
;;; Run as: guile --no-auto-compile ch-2.scm
;;;

(use-modules (ice-9 format))

(define sqrt5 (sqrt 5))
(define phi   (/ (+ 1 sqrt5) 2))

(define (stairs)
    (define n (read))
    (if (not (eof-object? n))
        (begin
            (format #t "~d\n"
                    (inexact->exact (round (/ (expt phi (+ n 1)) sqrt5))))
            (stairs)
        )
    )
)

(stairs)
