;;;
;;; See ../README.md
;;;

;;;
;;; Run as: guile --no-auto-compile ch-2.scm
;;;

(use-modules (ice-9 rdelim))
(use-modules (ice-9 format))

(define (add-list list elem)
    (cond ((null? list) (cons* elem '()))
          ((string=? (car list) elem) list)
          (else (cons (car list) (add-list (cdr list) elem)))))

(define (show-list list)
    (cond ((null? list) (newline))
          (else 
              (format #t "~a " (car list))
              (show-list (cdr list)))))

(define (main)
    (define line (read-line))
    (define l)
    (define str)
    (define out '())
    (if (not (eof-object? line))
        (begin
            (set! l (string-length line))
            (do  ((i 0 (1+ i)))
                 ((>= i l))
                 (do  ((j i (1+ j)))
                      ((>= j l))
                      (begin
                          (set! str (substring line i (+ j 1)))
                          (if (string=? str (string-reverse str))
                              (begin
                                  (set! out (add-list out str))
                              )
                          )
                      )
                 )
            )
          ; (display out)(newline)
            (show-list out)
            (main)
        )
    )
)

(main)

