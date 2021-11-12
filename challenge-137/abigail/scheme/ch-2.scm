;;;
;;; See ../README.md
;;;

;;;
;;; Run as: guile --no-auto-compile ch-2.scm
;;;

(use-modules (ice-9 format))

(define (reverse num)
    (define rev 0)
    (while (> num 0)
        (set! rev (* rev 10))
        (set! rev (+ rev (modulo num 10)))
        (set! num (truncate (/ num 10)))
    )
    rev
)

(define (ly n)
    (cond ((>= n 10000000)   1)
          ((= n (reverse n)) 0)
          (else (ly (+ n (reverse n))))))


(define (main)
    (define num (read))
    (if (not (eof-object? num))
        (begin
            (format #t "~d~%" (ly num))
            (main))))


(main)
