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
            (format #t "~d\n" (logior (logand num (lognot #xFF))
                                 (ash (logand num #x0F)  4)
                                 (ash (logand num #xF0) -4)))
            (main)
        )
    )
)

(main)
