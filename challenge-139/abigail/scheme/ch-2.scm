;;;
;;; See ../README.md
;;;

;;;
;;; Run as: guile --no-auto-compile ch-2.scm
;;;

(define BASE  10)
(define COUNT  5)

(define (is-long number)
    (define seen (make-array 0 number))
    (define rest 0)
    (define r #t)

    (do ((i 2 (1+ i)))
        ((> i number))
        (set! rest (modulo (+ (* rest BASE) BASE -1) number))
        (if (= (array-ref seen rest) 1)
            (set! r #f))
        (array-set! seen 1 rest))

    r
)

(do ((number 2 (1+ number)))
    ((= COUNT 0))
    (cond ((= (modulo BASE number) 0) #f)
          ((is-long number)
               (begin (display number)(newline)
                      (set! COUNT (- COUNT 1))))))

