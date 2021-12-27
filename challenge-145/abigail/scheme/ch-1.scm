;;;
;;; See ../README.md
;;;

;;;
;;; Run as: guile --no-auto-compile ch-1.scm < input-file
;;;

(use-modules (ice-9 rdelim))

(define (dotproduct a b)
    (if (null? a) 0
        (+ (* (car a) (car b))
              (dotproduct (cdr a) (cdr b)))))

(display (dotproduct (map string->number (string-split (read-line) #\ ))
                     (map string->number (string-split (read-line) #\ ))))
(newline)
