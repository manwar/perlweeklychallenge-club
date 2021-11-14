;;;
;;; See ../README.md
;;;

;;;
;;; Run as: guile --no-auto-compile ch-2.scm
;;;

(define (can-split target number)
    (define r #f)
    (cond ((> target number) #f)
          ((< target 0)      #f)
          ((= target number) #t)
          (else
            (begin 
                (do ((pow_10 10 (* 10 pow_10)))
                    ((or (> pow_10 number) r))
                    (set! r (can-split (- target (modulo number pow_10))
                                               (quotient number pow_10))))
                 r)))
)

    
(define (main)
    (define number (read))
    (define ssqq)
    (if (not (eof-object? number))
        (begin
            (set! ssqq (inexact->exact (round (sqrt number))))
            (if (and (> number 1) (can-split ssqq number))
                (display 1)
                (display 0))
            (newline)
            (main)
        )
    )
)

(main)
        
