;;;
;;; See ../README.md
;;;

;;;
;;; Run as: guile --no-auto-compile ch-2.scm < input-file
;;;

(use-modules (ice-9 rdelim))

(define (main)
    (define line (read-line))
    (define parts)
    (define a)
    (define b)
    (if (not (eof-object? line))
        (begin
            (set! parts (string-split line #\/))
            (set! a (string->number (list-ref parts 0)))
            (set! b (string->number (list-ref parts 1)))
            (do ((i 1 (1+ i)))
                ((or (= i 3) (= a 0) (= b 0)))
                (begin
                    (if (< a b) (set! b (- b a)) (set! a (- a b)))
                    (if (and (> a 0) (> b 0))
                        (begin
                            (display a)
                            (display "/")
                            (display b)
                            (display " ")
                        )
                    )
                )
            )
            (newline)
            (main)
        )
    )
)

(main)
