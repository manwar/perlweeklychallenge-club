(defun build-array (list)
  (let ((ret (make-list (list-length list))))
    (loop :for i :from 0 :below (list-length list)
	  :do (setf (nth i ret) (nth (nth i list) list)))
    ret))

(progn
  (print (build-array '(0 2 1 5 3 4)))
  (print (build-array '(5 0 1 2 3 4))))

