#lang racket
(require rackunit)


; https://stackoverflow.com/questions/977251/regular-expressions-and-negating-a-whole-character-group

(define (regexcheck x)
  (if
   (string-contains? x "-")
   (regexp-match* #rx"^[a-zA-Z]+\\-[a-zA-Z]+[$!?]*$" x)
   (regexp-match* #rx"^(?:(?![-,.]).)+[.!,-]*$" x)
   )
)

; 
(define (vtc z) (let-values ([(x y) (partition empty? (map regexcheck
                                                                  (string-split z " ")
                                                                  ))]) (length y)))

(check-equal? 3 (vtc "cat and dog"))
(check-equal? 2 (vtc "a-b c! d,e"))
(check-equal? 4 (vtc "hello-world! this is fun"))
(check-equal? 2 (vtc "ab- cd-ef gh- ij!" ))
(check-equal? 2 (vtc "wow! a-b-c nice."))

