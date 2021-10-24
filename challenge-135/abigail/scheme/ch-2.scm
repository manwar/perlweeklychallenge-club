;;;
;;; See ../README.md
;;;

;;;
;;; Run as: guile --no-auto-compile ch-2.scm < input-file
;;;

(use-modules (ice-9 regex))
(use-modules (ice-9 rdelim))
(use-modules (ice-9 iconv))
(use-modules (rnrs bytevectors))
(use-modules (srfi srfi-1))

(define pat   "^[0-9BCDFGHJKLMNPQRSTVWXYZ]{6}[0-9]$")
(define w     (list 1 3 1 7 3 9 1))


;;
;; Create a procedure 'byte->val'. It takes the ASCII value of a
;; character, and returns the corresponding number for the SEDOL
;; checksum (-10 for "A" .. "Z").
;;
(define ords  (bytevector->u8-list (string->bytevector "09A" "UTF-8")))
(define ord-0 (list-ref ords 0))
(define ord-9 (list-ref ords 1))
(define ord-A (list-ref ords 2))
(define (byte->val b)
    (if (<= b ord-9)
        (-  b ord-0)
        (-  b ord-A)))


(define (main)
    (define sedol (read-line))
    (define is-sedol)
    (define valid 0)
    (define check 0)
    (define values)
    (if (not (eof-object? sedol))
        (begin
            (set! valid 0)
            (set! check 0)
            (set! is-sedol (string-match pat sedol))
            (if (regexp-match? is-sedol)
                (begin
                    (set! values
                        (map-in-order byte->val
                            (bytevector->u8-list 
                                (string->bytevector
                                    (match:substring is-sedol 0) "UTF-8"))))
                    (set! check
                        (fold (lambda (weight val sum) (+ sum (* weight val)))
                              0 w values))
                    ;;
                    ;; A SEDOL is valid iff the checksum is a multiple of 10
                    ;;
                    (if (= 0 (modulo check 10)) (set! valid 1))
                )
            )
            (display valid)(newline)
            (main)
        )
    )
)

(main)
