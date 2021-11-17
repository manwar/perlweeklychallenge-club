;;;
;;; See ../README.md
;;;

;;;
;;; Run as: guile --no-auto-compile ch-1.scm < input-file
;;;

(use-modules (ice-9 rdelim))

;;
;; A list of 0 or 1 elements is sorted
;; A list where the first element is larger than the second is not sorted
;; Else, the list is sorted if the cdr of the list is sorted
;;
(define (is-sorted list)
    (cond ((< (length list) 2)                     1)
          ((> (list-ref list 0) (list-ref list 1)) 0)
          (else (is-sorted (cdr list))))
)

(define (main)
    (define line (read-line))
    (if (not (eof-object? line))
        (begin
            (display (is-sorted (map-in-order string->number
                                             (string-split line #\ ))))
            (newline)
            (main)
        )
    )
)

(main)
