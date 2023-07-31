(defun unique-sum (list)
  (flet ((get-keys (ht num)
	   (loop :for k :being :the :hash-keys :of ht
		 :when (= (gethash k ht) num)
		   :collect k)))
    (let ((ht (make-hash-table :size (list-length list))))
    (loop :for i :in list
	  :do (incf (gethash i ht 0)))
    (apply #'+ (get-keys ht 1)))))

(progn
  (print (unique-sum '(2 1 3 2)))
  (print (unique-sum '(1 1 1 1)))
  (print (unique-sum '(2 1 3 4))))

