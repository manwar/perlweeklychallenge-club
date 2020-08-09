; Perl Weekly Challenge #072 Task 1 Trailing Zeroes
; The following Lisp code use a primitive method
;   to count the trailing zeroes
 
(defun fact (num)
  (cond ((equal 1 num) 1)
    ((> num 1) (* (fact (- num 1)) num))
  )
))


(defun countzero (num)
  (if (zerop (mod num 10)) (+ 1 (countzero (/ num 10) ))
     '0
))

(defun tzero (n)
  (countzero (fact n))
)

(tzero 10) ; output 2

(tzero 7) ; output 1

(tzero 4) ; output 0

(tzero 25) ; output 6

(tzero 30) ; output 7

(tzero 50) ; output 12

(tzero 100) ; output 24


; values larger than 5327 give "Program stack overflow "; GNU CLISP 2.49.60+
