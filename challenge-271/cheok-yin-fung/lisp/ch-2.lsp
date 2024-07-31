; The Weekly Challenge 271
; Task 2 Sort by 1 bits

(defun bits (n) (setq acc nil)
  (loop
    (setq acc (cons (mod n 2) acc))
    (setq n (ash n -1))
    (when (= n 0) (return acc))))

(defun one-bits (n)
  (reduce #'+ (bits n)))

(defun sort-by-one-bits (lst)
  (sort lst #'(lambda (x y) (cond
    ((< (one-bits x) (one-bits y)) t) (t (< x y))))))

; > (sort-by-one-bits '(0 1 2 3 4 5 6 7))
; (0 1 2 4 3 5 6 7)

