;;;
;;; See ../README.md
;;;

;;;
;;; Run as: guile --no-auto-compile ch-2.scm
;;;

(use-modules (ice-9 format))

(define tokens   12)
(define max_take  3)

;;;
;;; Recursive method playing the game. As argument it gets the number
;;; of tokens left. It plays a single move, then calls itself with
;;; the updated number of moves. If the number of tokens left is 0,
;;; the method simply returns.
;;;
;;; If the player inputs an invalid number of tokens (too many, not
;;; enough, not an integer), the method calls itself with the same
;;; number of tokens. Otherwise, it calls it self with the updated
;;; number of tokens.
;;;

(define (play tokens)
    (define take   0)
    (define takes  0)
    (define s     "")
    (if (> tokens 0)
        (begin
            (format #t "How many tokens do you take? (~2d tokens are left) "
                        tokens)

            (set! take (read))
            (if (integer? take)
                (if (<= 1 take max_take)
                    (begin
                        (set! takes (- (+ max_take 1) take))
                        (format #t "Computer takes ~d token~a\n" takes 
                                    (if (= takes 1) "" "s"))

                        (set! tokens (- tokens (+ max_take 1)))
                    )
                )
            )
            (play tokens)
        )
    )
)

(play tokens)

(display "Computer wins\n")
