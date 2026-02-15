#lang br
(require rackunit)
(require racket/format)

(define (justifier text length)
    (~a text #:min-width length #:align 'center
    #:right-pad-string "*" #:left-pad-string "*")
  )

(check-equal? "*hi**" (justifier "hi" 5))
(check-equal?  "***Code***" (justifier "Code" 10))
(check-equal? "**Hello**" (justifier "Hello" 9))
(check-equal? "Perl" (justifier "Perl" 4))
(check-equal? "***A***" (justifier "A" 7))
(check-equal? "*****" (justifier "" 5))
