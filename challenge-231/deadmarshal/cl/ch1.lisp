(defun min-max (list)
  (let ((min (apply #'min list))
	(max (apply #'max list)))
    (if (< (list-length list) 3)
	-1
	(remove-if #'(lambda (n) (or (= n min) (= n max))) list))))

(progn
  (print (min-max '(3 2 1 4)))
  (print (min-max '(3 1)))
  (print (min-max '(2 1 3))))

