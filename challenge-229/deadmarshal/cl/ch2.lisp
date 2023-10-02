(defun keys (ht)
  (loop :for k :being :the :hash-keys :of ht
	:collect k))

(defun two-out-of-three (list)
  (let ((ht (make-hash-table :size (list-length list))))
    (mapcar
     #'(lambda (a) (mapcar #'(lambda (elem) (incf (gethash elem ht 0)))
		      (remove-duplicates a)))
     list)
    (sort (remove-if-not #'(lambda (k) (>= (gethash k ht) 2)) (keys ht))
	  #'<)))

(progn
  (print (two-out-of-three '((1 1 2 4) (2 4) (4))))
  (print (two-out-of-three '((4 1) (2 4) (1 2)))))

