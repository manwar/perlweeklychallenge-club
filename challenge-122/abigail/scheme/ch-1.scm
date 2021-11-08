;;;
;;; See ../README.md
;;;

;;;
;;; Run as: guile --no-auto-compile ch-1.scm < input-file
;;;


(use-modules (ice-9 format))

(define s 0)
(define c 0)

(define (main)
    (define n (read))
    (if (not (eof-object? n))
        (begin
            (set! s (+ s n))
            (set! c (+ c 1))
            (format #t "~d\n" (/ s c))
            (main)
        )
    )
)

(main)
