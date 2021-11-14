;;;
;;; See ../README.md
;;;

;;;
;;; Run as: guile --no-auto-compile ch-1.scm
;;;

(define lookup (list (list 261 260 260 261 261 261 261) 
                     (list 262 261 260 261 262 262 262)))

(define SUNDAY    0)
(define MONDAY    1)
(define TUESDAY   2)
(define WEDNESDAY 3)
(define THURSDAY  4)
(define FRIDAY    5)
(define SATURDAY  6)

(define anchors (list TUESDAY SUNDAY FRIDAY WEDNESDAY))

(define (doomsday year)
    (define anchor  (list-ref anchors (modulo (quotient year 100) 4)))
    (define y       (modulo year 100))
    (modulo (+ (quotient y 12)
               (modulo   y 12)
               (quotient (modulo y 12) 4) anchor) 7)
)

(define (is_leap year)
    (if (or (= 0 (modulo year 400)) 
            (and (= 0 (modulo year 4))
                 (< 0 (modulo year 100)))) 1 0)
)
    
(define (main)
    (define year (read))
    (if (not (eof-object? year))
        (begin
            (display (list-ref (list-ref lookup (is_leap year))
                               (doomsday year)))
            (newline)
            (main)
        )
    )
)

(main)
        
