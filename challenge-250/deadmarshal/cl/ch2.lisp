(defun alphanumeric-string-value (list)
  (apply #'max (mapcar
		#'(lambda (x) (if (every #'(lambda (c) (digit-char-p c)) x)
			     (parse-integer x)
			     (length x)))
		list)))

(progn
  (print (alphanumeric-string-value '("perl" "2" "000" "python" "r4ku")))
  (print (alphanumeric-string-value '("001" "1" "000" "0001"))))

