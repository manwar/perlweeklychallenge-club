(defun left-right-sum-diff (list)
  (let ((left 0)
	(right (apply #'+ (subseq list 1))))
    (loop :for i :from 0 :below (list-length list)
	  :do (format t "~A " (abs (- left right)))
	      (incf left (nth i list))
	      (when (< i (1- (list-length list)))
		(decf right (nth (1+ i) list)))))
  (format t "~%"))

(progn
  (left-right-sum-diff '(10 4 8 3))
  (left-right-sum-diff '(1))
  (left-right-sum-diff '(1 2 3 4 5)))

