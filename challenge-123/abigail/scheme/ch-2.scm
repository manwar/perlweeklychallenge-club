;;;
;;; See ../README.md
;;;

;;;
;;; Run as: guile --no-auto-compile ch-2.scm
;;;

(use-modules (ice-9 format))

;;;
;;; Give the coordinates of two points, return the (square of) the
;;; distance between them.
;;;
(define (dist x1 x2 y1 y2)
    (+ (* (- x1 x2) (- x1 x2)) (* (- y1 y2) (- y1 y2)))
)

(define (main)
    (define x1 (read))
    (define y1 (read))
    (define x2 (read))
    (define y2 (read))
    (define x3 (read))
    (define y3 (read))
    (define x4 (read))
    (define y4 (read))

    (if (not (eof-object? x1))
        (begin
            (if (and (= (dist x1 x2 y1 y2) (dist x2 x3 y2 y3)   ;;; Edges
                        (dist x3 x4 y3 y4) (dist x4 x1 y4 y1))  ;;; Edges
                     (= (dist x1 x3 y1 y3) (dist x2 x4 y2 y4))) ;;; Diagonals
                (format #t "1\n")
                (format #t "0\n")
            )
            (main)
        )
    )
)

(main)

