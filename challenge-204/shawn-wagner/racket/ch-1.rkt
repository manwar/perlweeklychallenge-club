#lang racket/base

; Run with: raco test ch-1.rkt

(require racket/list)
(module+ test (require rackunit))


(define (monotonic? list [way 'unknown])
  (cond
    ((empty? list) #t) ; Empty list is always monotonic
    ((empty? (rest list)) #t) ; As is one with a single element
    ((eq? way 'increasing) ; If increasing, second element must be >= first
     (and
      (>= (second list) (first list))
      (monotonic? (rest list) 'increasing)))
    ((eq? way 'decreasing) ; If decreasing, second element must be <= first
     (and
      (<= (second list) (first list))
      (monotonic? (rest list) 'decreasing)))
    ((> (first list) (second list)) ; Order currently unknown, appears to be decreasing
     (monotonic? (rest list) 'decreasing))
    ((< (first list) (second list)) ; Order currently unknown, appears to be increasing
     (monotonic? (rest list) 'increasing))
    (else ; Still unknown - first two elements are equal
     (monotonic? (rest list) 'unknown))))

(module+ test
  (check-true (monotonic? '(1 2 2 3)))
  (check-false (monotonic? '(1 3 2)))
  (check-true (monotonic? '(6 5 5 4))))
