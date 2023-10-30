(defun frequency-sort (list)
  (let ((ht (make-hash-table :size (list-length list))))
    (mapcar #'(lambda (s) (incf (gethash s ht 0))) list)
    (sort list #'(lambda (a b) (let ((x (gethash a ht))
				(y (gethash b ht)))
			    (if (= x y)
				(< b a)
				(< x y)))))))

(progn
  (print (frequency-sort '(1 1 2 2 2 3)))
  (print (frequency-sort '(2 3 1 3 2)))
  (print (frequency-sort '(-1 1 -6 4 5 -6 1 4 1))))

