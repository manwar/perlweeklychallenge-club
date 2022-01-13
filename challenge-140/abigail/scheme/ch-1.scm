;;;
;;; See ../README.md
;;;

;;;
;;; Run as: guile --no-auto-compile ch-1.scm
;;;

(use-modules (ice-9 rdelim))
(use-modules (srfi  srfi-1))

(define (bin2dec bin) 
    (define len (string-length bin))
    (cond ((= len 0) 0)
          (else (+ (string->number (string-take-right bin 1))
                   (* 2 (bin2dec   (string-drop-right bin 1)))))))

(define (_dec2bin dec)
    (cond ((= dec 0) "")
          (else (string-concatenate
                   (list (_dec2bin       (floor-quotient dec 2))
                         (number->string (modulo         dec 2)))))))

(define (dec2bin dec)
    (cond ((= dec 0) "0")
          (else (_dec2bin dec))))

(define (main)
    (define line (read-line))
    (define parts)
    (if (not (eof-object? line))
        (begin
            (display (dec2bin (fold + 0 (map bin2dec (string-split line #\ )))))
            (newline)
            (main)
        )
    )
)


(main)
