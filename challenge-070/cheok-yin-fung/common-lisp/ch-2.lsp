;; Perl Weekly Challenge 070 Task 2 Gray Code Sequence

(setf n 4)
(setf a '(0 1))
(setf m (- n 1))

(loop for i from 1 upto m do
  (setf 2power (expt 2 i))
  (defun add2pow (terms) (+ 2power terms))
  (setf b (reverse a))
  (setf b (mapcar #'add2pow b))
  (setf a (append a b))
)

;; now the variable a stores the n-bit gray code sequence

a 
