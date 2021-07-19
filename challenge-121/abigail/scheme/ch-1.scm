;;;
;;; See ../README.md
;;;

;;;
;;; Run as: guile --no-auto-compile ch-1.scm
;;;

(use-modules (ice-9 format))

(define (main)
    (define m (read))
    (define n (read))
    (if (not (eof-object? m))
        (begin
            (format #t "~d\n" (logxor m (ash 1 (- n 1))))
            (main)
        )
    )
)

(main)
