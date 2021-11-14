;;;
;;; See ../README.md
;;;

;;;
;;; Run as: guile --no-auto-compile ch-1.scm < input-file
;;;

;;;
;;; Find the GCD, using Stein's algorithm
;;;    (https://en.wikipedia.org/wiki/Binary_GCD_algorithm)
;;;
(define (gcd u v)
    (define u_odd (= (modulo u 2) 1))
    (define v_odd (= (modulo v 2) 1))
    (cond ((= u v) u)
          ((= u 0) v)
          ((= v 0) u)
          ((and (not u_odd) (not v_odd)) (ash (gcd (ash u -1) (ash v -1)) 1))
          ((and (not u_odd)      v_odd)       (gcd (ash u -1)      v))
          ((and      u_odd  (not v_odd))      (gcd      u     (ash v -1)))
          ((> u v)                            (gcd (- u v) v))
          (else                               (gcd (- v u) u)))
)

;;;
;;; Return #t if number is a power of n, that is, number == n ^ p
;;; for some non-negative integer p. Return #f otherwise.
;;;
(define (is-power-of-n number n)
    (cond ((< number 1) #f)
          ((= number 1) #t)
          ((> (modulo number n) 0) #f)
          (else (is-power-of-n (/ number n) n)))
)

(define (is-power-of-2 number)
    (is-power-of-n number 2)
)

(define (main)
    (define m (read))
    (define n (read))
    (define r)
    (if (not (eof-object? m))
        (begin
            (display (cond ((= (modulo n 2) 1) 0)
                           ((= (modulo m 2) 1) 0)
                           (else
                               (begin
                                   (set! r (gcd m n))
                                   (if (and (> r 1) (is-power-of-2 r)) 1 0)
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
