(defun empty-array (list count)
  (if (null list)
      count
      (if (= (car list) (apply #'min list))
	  (empty-array (cdr list) (1+ count))
	  (empty-array (append (cdr list) (list (car list)))
		       (1+ count)))))

(progn
  (print (empty-array '(3 4 2) 0))
  (print (empty-array '(1 2 3) 0)))

