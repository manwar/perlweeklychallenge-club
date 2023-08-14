(defun lexicographic-order (list)
  (let ((count 0))
    (mapcar #'(lambda (str)
		(let* ((s (copy-seq str))
		       (sorted (sort s #'char-lessp)))
		  (when (and (string/= str sorted)
			     (string/= str (reverse sorted)))
		    (incf count))))
	    list)
    count))

(progn
  (print (lexicographic-order '("abc" "bce" "cae")))
  (print (lexicographic-order '("yxz" "cba" "mon"))))

