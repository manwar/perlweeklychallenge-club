#lang typed/racket/base

; Run with: racket ch-2.rkt

; Is using a standard library cheating?

(require math/array)

(: reshape (All (a) ((Array a) Index Index -> (U (Array a) Zero))))
(define (reshape arr r c)
  (with-handlers
    ([exn? (lambda (exn) 0)])
    (array-reshape arr (vector r c))))

(: doit : (Array Integer) Index Index -> Void)
(define (doit arr r c)
  (printf "~V => ~V~%" arr (reshape arr r c)))

(doit (array #[#[1 2] #[3 4]]) 1 4)
(doit (array #[#[1 2 3] #[4 5 6]]) 3 2)
(doit (array #[#[1 2]]) 3 2)
