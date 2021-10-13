;;;
;;; See ../README.md
;;;

;;;
;;; Run as: guile --no-auto-compile ch-1.scm
;;;

(use-modules (ice-9 format))

(define t #@1(789 798 879 897 978))
(do ((i 1 (1+ i)))
    ((> i (array-length t)))
    (format #t "1023456~d\n" (array-ref t i)))
