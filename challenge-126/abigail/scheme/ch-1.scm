;;;
;;; See ../README.md
;;;

;;;
;;; Run as: guile --no-auto-compile ch-1.scm < input-file
;;;

(use-modules (ice-9 rdelim))

;;
;; Return the first character of a string, *as a number*.
;; We won't call this with an empty or non-numeric string.
;;
(define (first str)(string->number (string-take str 1)))


(define (_nr-of-ones input result seen-one)
    (if (string-null? input) result
        (_nr-of-ones (string-drop input 1)
                     (+ (* result 9)
                        (cond (seen-one             8)
                              ((> (first input) 0) (- (first input) 1))
                              (else                 0)))
                     (or seen-one (= (first input) 1))))
)

;;
;; Wrapper around _nr-of-ones, supplying additional parameters.
;;
(define (nr-of-ones input)(_nr-of-ones input 0 #f))


(define (main)
    (define line (read-line))
    (if (not (eof-object? line))
        (begin
            (display (nr-of-ones line))(newline)
            (main)
        )
    )
)

(main)
