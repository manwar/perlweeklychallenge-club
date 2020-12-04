;;; How to run:
;;; $ sbcl --script ch-1.lisp 100
;;; 
;;; 13015 

(defvar n (parse-integer (nth 1 *posix-argv*)))

(defvar s 0)

(loop for x from 1 to n
    do (
        loop for y from (+ 1 x) to n
            do (setq s (+ s (gcd x y)))        
    )
)

(print s)
(terpri)
