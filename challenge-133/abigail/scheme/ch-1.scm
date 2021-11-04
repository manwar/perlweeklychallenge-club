;;;
;;; See ../README.md
;;;

;;;
;;; Run as: guile --no-auto-compile ch-1.scm < input-file
;;;


(use-modules (ice-9 format))

(define (main)
    (define num (read))
    (if (not (eof-object? num))
        (begin
            (format #t "~,d~%" (inexact->exact (floor (exp (/ (log num) 2)))))
            (main)
        )
    )
)

(main)
