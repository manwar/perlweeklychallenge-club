;;;
;;; See ../README.md
;;;

;;;
;;; Run as: guile --no-auto-compile ch-2.scm
;;;

(use-modules (srfi srfi-1))

(define small_primes (list 2 3 5 7 11 13 17 19 23 29 31))
(define base  10)
(define count 10)

(define (_factors number primes)
    (cond ((null? primes) (if (> number 1) (list number) '()))
          ((= (modulo number (car primes)) 0)
                  (append (list (car primes))
                          (_factors (/ number (car primes)) primes)))
          (else (_factors number (cdr primes)))))


(define (factors number) (_factors number small_primes))

(define (_digitsum number) 
    (if (= number 0) 0
        (+ (modulo number base) (_digitsum (floor/ number base)))))

(define (digitsum numbers)
    (fold + 0 (map _digitsum numbers)))


(define (smith count from)
    (define f)
    (if (> count 0)
        (begin
            (set! f (factors from))
            (if (and (not (null? (cdr f)))
                     (= (digitsum (list from)) (digitsum f)))
                (begin
                    (display from)(newline)
                    (smith (- count 1) (+ from 1))
                )
                (smith count (+ from 1))
            )
        )
    )
)

(smith count 2)
