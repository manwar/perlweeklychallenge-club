#lang racket/base

(require srfi/43) ; For vector-swap!

(define (vector-partition! vec left right pivot-index <?)
  (define pivot (vector-ref vec pivot-index))
  (vector-swap! vec pivot-index right)
  (let loop ([i left]
             [store-index left])
    (cond
      ((< i right)
       (cond
         ((<? (vector-ref vec i) pivot)
          (vector-swap! vec store-index i)
          (loop (+ i 1) (+ store-index 1)))
         (else
          (loop (+ i 1) store-index))))
      (else
       (vector-swap! vec right store-index)
       store-index))))

;;; Basic quickselect
(define (kth-element! vec k <? [left 0] [right (- (vector-length vec) 1)])
  (if (= left right)
      (vector-ref vec left)
      (let* ([pivot-index (random left (+ right 1))]
             [pivot-index (vector-partition! vec left right pivot-index <?)])
        (cond
          ((= k pivot-index)
           (vector-ref vec k))
          ((< k pivot-index)
           (kth-element! vec k <? left (- pivot-index 1)))
          (else
           (kth-element! vec k <? (+ pivot-index 1) right))))))

(define (solution vec)
  (if (< (vector-length vec) 3)
      (apply max (vector->list vec))
      (kth-element! (vector-copy vec) 2 >)))

(define (demo num vec)
  (printf "Example ~A: Third highest element of ~S -> ~A~%" num vec (solution vec)))

(demo 1 #(5 3 4))
(demo 2 #(5 6))
(demo 3 #(5 4 4 3))
