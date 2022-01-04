;;;
;;; See https://theweeklychallenge.org/blog/perl-weekly-challenge-001
;;;

;;;
;;; Run as: guile --no-auto-compile ch-2.scm
;;;


(use-modules (ice-9 rdelim))

(define (show i)
    (cond ((= (euclidean-remainder i 15) 0) "fizzbuzz")
          ((= (euclidean-remainder i  5) 0)     "buzz")
          ((= (euclidean-remainder i  3) 0) "fizz"    )
          (else i))
)

(define (main)
    (define max (read-line))
    (if (not (eof-object? max))
        (begin
            (do ((i 1 (1+ i)))
                ((> i (string->number max)))
                (display (show i)) (newline))
            (main)
        )
    )
)

(main)
