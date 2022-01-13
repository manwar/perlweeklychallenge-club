;;;
;;; See ../README.md
;;;

;;;
;;; Run as: guile --no-auto-compile ch-2.scm < input-file
;;;

(use-modules (ice-9 rdelim))
(use-modules (srfi  srfi-1))

;;
;; Return the number of divisors of n, where the divisors don't
;; exceed neither i nor j
;;
(define (divisors n i j)
    (define s (inexact->exact (round (sqrt n))))
    (define c 0)
    (do ((d 1 (1+ d)))
        ((> d s))
        (if (= (modulo n d) 0)
            (begin
                (if (and (<= d i) (<= (/ n d) j)) (set! c (+ c 1)))
                (if (and (<= d j) (<= (/ n d) i)) (set! c (+ c 1)))
                (if (= n (* d d))                 (set! c (- c 1)))
            )
        )
    )
    c
)
            


(define (find-kth list)
    (define i (list-ref list 0))
    (define j (list-ref list 1))
    (define k (list-ref list 2))
    (define n 0)
    (while (> k 0)
        (begin
            (set! n (+ 1 n))
            (set! k (- k (divisors n i j)))
        )
    )
    n
)

(define (main)
    (define line (read-line))
    (define parts)
    (if (not (eof-object? line))
        (begin
            (display (find-kth (map string->number (string-split line #\ ))))
            (newline)
            (main)
        )
    )
)


(main)
