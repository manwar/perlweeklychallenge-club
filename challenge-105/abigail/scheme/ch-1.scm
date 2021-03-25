;;;
;;; See ../README.md
;;;

;;;
;;; Run as: guile --no-auto-compile ch-1.scm < input-file
;;;
;;; Input will consist of lines; each line will have two numbers, N and k
;;; N > 0, k > 0. For each line of input, we output a line with the Nth
;;; root of k.
;;;
;;; We're not doing any input validations; we're assuming it's correct.
;;;

;;;
;;; To find the Nth root of a number k, we just raise k to the power 1/N.
;;;

(use-modules (ice-9 format))

(define (nthroot)
    (define N (read))
    (if (not (eof-object? N))
        (begin
            (format #t "~f\n" (expt (read) (/ 1 N)))
            (nthroot)
        )
    )
)

(nthroot)
