;;;
;;; See ../README.md
;;;

;;;
;;; Run as: guile --no-auto-compile ch-2.scm < input-file
;;;

(use-modules (ice-9 rdelim))

(define (fc n)              (string->number (string-take n 1)))
(define (tail n)                            (string-drop n 1))
(define (n_prefix prefix n) (if (= prefix -1) (fc n) (+ (* prefix 10) (fc n))))

(define (substrings n m prefix max)
    (if (string-null? n)
        (if (and (> prefix -1)
                 (< prefix max)
                 (= (modulo prefix m) 0)) 1 0)
        (+ (substrings (tail n) m (n_prefix prefix n) max)
           (substrings (tail n) m           prefix    max))))


(define (main)
    (define line (read-line))
    (define parts)
    (if (not (eof-object? line))
        (begin
            (set! parts (string-split line #\ ))
            (display (substrings (list-ref parts 0)
                                 (string->number (list-ref parts 1))
                                 -1
                                 (string->number (list-ref parts 0))))
            (newline)
            (main)
        )
    )
)

(main)
