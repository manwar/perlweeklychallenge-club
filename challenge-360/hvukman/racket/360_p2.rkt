#lang br
(require rackunit)

(define (word-sorter x)
  (let ([inp (string-split x)])
  (string-join (sort inp string-ci<?))
  )
  )

(check-equal?
 "brown fox quick The"
 (word-sorter "The quick brown fox"))

(check-equal?
 "are Hello How World! you?"
 (word-sorter  "Hello    World!   How   are you?"))

(check-equal?
 "Hello"
 (word-sorter  "Hello"))

(check-equal?
 "are Hello, How World! you?"
 (word-sorter  "Hello, World! How are you?"))

(check-equal?
 "2 3 and apples bananas! have I"
 (word-sorter "I have 2 apples and 3 bananas!"))