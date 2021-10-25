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
;;; Return #t if n is a power of 2, other than 1
;;;
(define (is-power-of-2 n)
    (cond ((= (modulo n 2) 1) #f)
          ((= n 2) #t)
          (else (is-power-of-2 (/ n 2)))))

(define (main)
    (define m (read))
    (define n (read))
    (if (not (eof-object? m))
        (begin
            (display (if (is-power-of-2 (gcd m n)) 1 0))(newline)
            (main)
        )
    )
)

(main)
