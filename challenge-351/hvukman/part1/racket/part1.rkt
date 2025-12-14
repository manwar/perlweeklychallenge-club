#lang racket
(require rackunit)


(define (filterx x y)
  (filter (lambda (z) (not (= y z))) x)
  )

(define (newavg x)
(let* (
      [inp x]
      [max (apply max inp)]
      [min (apply min inp)]
      [new (filterx (filterx inp max) min)]
      )
    (if (= 0 (length new))
        0
        (/ (apply + new) (length new))
        )
  )
)

(check-equal? 5250
  (newavg '(8000 5000 6000 2000 3000 7000))
              )
(check-equal? 95000
              (newavg '(100000 80000 110000 90000))
              )
(check-equal? 0 (newavg '(2500 2500 2500 2500)) )
(check-equal? 0 (newavg '(2000)))
(check-equal? 3500 (newavg '(1000 2000 3000 4000 5000 6000)))
