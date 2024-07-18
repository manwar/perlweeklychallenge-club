; The Weekly Challenge 271
; Task 1 Maximum Ones

(defun count-one (lst &aux result) (setq result 0)
  (dolist (x lst)
    (cond
      ((equalp 1 x) (setq result (+ result 1)))
      (t ())))
  result)

(defun find-sum (matrix)
  (mapcar (lambda (row) (reduce #'+ row)) matrix)
))

(defun find-max (matrix &aux ans)
  (setq ones (find-sum matrix)) (setq rowth 0) (setq ans 1) (setq maximum 0)
  (dotimes (i (length matrix))
    (setq rowth (+ 1 rowth))
    (cond
      ((> (nth i ones) maximum) (setq maximum (nth i ones)) (setq ans rowth)))) 
ans)
