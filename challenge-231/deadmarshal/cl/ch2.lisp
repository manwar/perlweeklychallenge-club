(defun senior-citizens (list)
  (flet ((to-ages (list)
	   (mapcar #'(lambda (s)
		       (let ((len (- (length s) 4)))
			 (parse-integer (subseq s len (+ len 2)))))
		   list)))
    (count-if #'(lambda (n) (>= n 60)) (to-ages list))))

(progn
  (print (senior-citizens '("7868190130M7522"
			    "5303914400F9211"
			    "9273338290F4010")))
  (print (senior-citizens '("1313579440F2036"
			    "2921522980M5644"))))

