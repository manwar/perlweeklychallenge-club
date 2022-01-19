;;;
;;; See https://theweeklychallenge.org/blog/perl-weekly-challenge-001
;;;

;;;
;;; Run as: guile --no-auto-compile ch-1.scm
;;;


(use-modules (ice-9 rdelim))
(use-modules (ice-9 string-fun))

(define (main)
    (define line (read-line))
    (if (not (eof-object? line))
        (begin
            (display (string-replace-substring line "e" "E"))
            (newline)
            (display (string-count line #\e))
            (newline)
            (main)
        )
    )
)

(main)
