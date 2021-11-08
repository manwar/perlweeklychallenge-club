;;;
;;; See ../README.md
;;;

;;;
;;; Run as: guile --no-auto-compile ch-2.scm < input-file
;;;

(define (_count target this_fib prev_fib)
    (cond ((< target this_fib) 0)
          ((= target this_fib) 1)
          (else (+ (_count (- target this_fib) (+ this_fib prev_fib) this_fib)
                   (_count    target           (+ this_fib prev_fib) this_fib)))
    )
)

(define (count target)
    (_count target 1 1)
)

(define (main)
    (define n (read))
    (if (not (eof-object? n))
        (begin
            (display (count n))(newline)
            (main)
        )
    )
)

(main)
