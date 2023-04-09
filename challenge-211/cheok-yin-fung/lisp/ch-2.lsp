" The Weekly Challenge 211
" Task 2 Split Same Average
" reference:
" https://rosettacode.org/wiki/Power_set#Common_Lisp

(defun avg (xs) 
  (if (eq xs nil) 
      nil
      (/ (sum xs) (length xs))))

(defun ssa (xs)
  (setq a (avg xs))
  (setq ans nil)
   (loop for i below (expt 2 (- (length xs) 1)) do
     (if (eq ans nil)
       (progn
         (setq s ())
         (loop for j below i for x in xs do (if (logbitp j i) (setq s (cons x s)))) 
         (setq ans (eql (avg s) a)))))
  ans))


(ssa '(1 2 3 4)) "T
(ssa '(1 3)) "NIL
(ssa '(2 2 2)) "T

