" The Weekly Challenge 211
" Task 1 Toeplitz Matrix

(defun tm (mat)
  (setq ans t)
  (setq m (length mat))
  (setq n (length (nth 0 mat)))
  (setq kk (min m n))
  (setq a (nth 0 (nth 0 mat))) 
  (loop for i from 0 to (- kk 1) do 
    (setq ans (and 
      ans (eq a (nth i (nth i mat))))))
ans)


(tm '((4 3 2 1) (5 4 3 2) (6 5 4 3))) "T
(tm '((1 2 3) (3 2 1))) "NIL
