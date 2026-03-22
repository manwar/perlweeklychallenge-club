#lang racket
(require rackunit)

(define (numtolist x)
  (map string->number (map string (string->list x)))
    )

(define (alphabetindexdigitsum y k)
    (let (
      [conversion 
       (string-join (map number->string (map (lambda (x) (- x 96)) (map char->integer (string->list y)))) "")]    
      )  
      (do (
           (start (apply + (numtolist  conversion)) (apply + (numtolist (number->string start))))
             (rem k (+ 1 k))
             )
          ((< k rem) start)
        
          ))
  )


(check-equal? 6 (alphabetindexdigitsum "abc" 1))
(check-equal? 9 (alphabetindexdigitsum "az" 2))
(check-equal? 6 (alphabetindexdigitsum "cat" 1))
(check-equal? 8 (alphabetindexdigitsum "dog" 2))
(check-equal? 6 (alphabetindexdigitsum "perl" 3))
