(ql:quickload :alexandria)

(defun num-to-list (n)
  (map 'list #'digit-char-p (prin1-to-string n)))

(defun separate-digits (list)
  (alexandria:flatten
   (mapcar #'(lambda (x) (let ((s (prin1-to-string x)))
		      (if (= (length s) 1)
			  x
			  (separate-digits (num-to-list x)))))
	   list)))

(progn
  (print (separate-digits '(1 34 5 6)))
  (print (separate-digits '(1 24 51 60))))

