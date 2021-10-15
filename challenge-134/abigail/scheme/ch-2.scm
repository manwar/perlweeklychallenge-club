;;;
;;; See ../README.md
;;;

;;;
;;; Run as: guile --no-auto-compile ch-2.scm < input-file
;;;


(define (main)
    (define m (read))
    (define n (read))
    (define count 0)
    (define seen #())
    (if (not (eof-object? m))
        (begin
            (set! seen (make-array 0 (+ 1 (* m n))))
            (do ((i 1 (1+ i)))
                ((> i n))
                (begin
                    (do ((j 1 (1+ j)))
                        ((> j m))
                        (begin
                            (if (= (array-ref seen (* i j)) 0)
                                (begin
                                    (array-set! seen 1 (* i j))
                                    (set! count (1+ count))
                                )
                            )
                        )
                    )
                )
            )
            (display count)
            (newline)
            (main)
        )
    )
)

(main)
