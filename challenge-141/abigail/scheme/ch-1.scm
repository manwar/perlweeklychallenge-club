;;;
;;; See ../README.md
;;;

;;;
;;; Run as: guile --no-auto-compile ch-1.scm
;;;


(define (list-divisors count nr-of-divisors n)
    (define c)
    (define s (inexact->exact (round (sqrt n))))
    (if (> count 0)
        (begin
            (if (not (= n (* s s)))
                (begin
                    (set! c 0)
                    (do ((d 1 (1+ d)))
                        ((or (> d s) (> c nr-of-divisors)))
                        (if (= (modulo n d) 0)
                            (set! c (+ c 2))))
                    (if (= c nr-of-divisors)
                        (begin 
                            (display n)(newline)
                            (list-divisors (- count 1) nr-of-divisors (+ n 1)))
                        (list-divisors count nr-of-divisors (+ n 1))))
                (list-divisors count nr-of-divisors (+ n 1))))))


(list-divisors 10 8 1)
                
