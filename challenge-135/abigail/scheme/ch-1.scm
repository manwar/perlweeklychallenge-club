;;;
;;; See ../README.md
;;;

;;;
;;; Run as: guile --no-auto-compile ch-1.scm < input-file
;;;

(use-modules (ice-9 regex))
(use-modules (ice-9 rdelim))

(define (main)
    (define line (read-line))
    (define is-number)
    (define number)
    (define ll)
    (if (not (eof-object? line))
        (begin
            (set! is-number (string-match "^[-+]?([0-9]+)$" line))
            (if (not is-number)
                (display "not an integer")
                (begin
                    (set! number (match:substring is-number 1))
                    (set! ll (string-length number))
                    (if (= (modulo ll 2) 0)
                        (display "even number of digits")
                        (if (< ll 3)
                            (display "too short")
                            (display (substring number (/ (- ll 3) 2)
                                                       (/ (+ ll 3) 2)))
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
