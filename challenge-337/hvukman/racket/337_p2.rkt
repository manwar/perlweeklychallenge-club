#lang racket
(require racket/list)
(require rackunit)

; create list with row and columns
(define (CreateMat row column)
  (build-list row (lambda (x) (make-list column 0)))
  )

; increase row y
(define (IncRow x y)
 (list-set x y (map (lambda (z) (+ z 1) ) (list-ref x y)))
  )

; increase column y
(define (IncCol x y)
  (list-set x y (+ (list-ref x y) 1))
  )

; main function increases col and row
(define (Odd z y)
      (map (lambda (x) (IncCol x (cadr y))) (IncRow
                  z (car y)))

)

; if cdr Y not empty do the oddloop
(define (Oddloop X Y)
  (if (not (equal? Y '()))
      (Oddloop (Odd X (car Y)) (cdr Y))
      X
     )
  )

; function for inputs
(define (func X Y Z)
(let ([row X] [col Y] [pos Z])
  (apply + (map (lambda (x) (length x)) (map (lambda (x)
     (filter odd? x)) (Oddloop (CreateMat row col) pos)))))
)

(check-equal? (func 2 3 '( (0 1) (1 1) )) 6)
(check-equal? (func 2 2 '( (1 1) (0 0) )) 0)
(check-equal? (func 3 3 '( (0 0) (1 2) (2 1) )) 0)
(check-equal? (func 1 5 '( (0 2) (0 4) )) 2)
(check-equal? (func 4 2 '( (1 0) (3 1) (2 0) (0 1) )) 8)

(func 2 3 '( (0 1) (1 1) ))
(func 2 2 '( (1 1) (0 0) ))
(func 3 3 '( (0 0) (1 2) (2 1) ))
(func 1 5 '( (0 2) (0 4) ))
(func 4 2 '( (1 0) (3 1) (2 0) (0 1) ))
