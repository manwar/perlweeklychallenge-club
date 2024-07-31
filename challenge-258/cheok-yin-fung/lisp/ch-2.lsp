; The Weekly Challenge 258
; Task 2 Sum of Values

(defun bits (n) (setq acc nil)
  (loop
    (setq acc (cons (mod n 2) acc))
    (setq n (ash n -1))
    (when (= n 0) (return acc))))

(defun one-bits (n)
  (reduce #'+ (bits n)))

(defun sov (lst k)
  (setq sum 0)
  (dotimes (i (length lst))
    (cond
      ((equalp k (one-bits i)) (print i) (setq sum (+ (nth i lst) sum))))) 
sum)

; > (sov '(2 5 9 11 3) 1)
; 17
; >(sov '(2 5 9 11 3) 2)
; 11
; > (sov '(2 5 9 11 3) 0) 
; 2

