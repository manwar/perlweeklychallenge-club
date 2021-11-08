;;;
;;; See ../README.md
;;;

;;;
;;; Run as: guile --no-auto-compile ch-1.scm < input-file
;;;


(use-modules (ice-9 format))

(define (main)
    (define num (read))
    (if (not (eof-object? num))
        (begin
            (format #t "~d\n" (logior (ash (logand num #x55)  1)
                                      (ash (logand num #xAA) -1)))
            (main)
        )
    )
)

(main)
