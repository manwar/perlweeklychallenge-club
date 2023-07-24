(defmacro range (start end &optional (step 1))
  `(loop :for i :from ,start :below ,end :by ,step :collect i))

(defun shuffle-string (str list)
  (let ((ret (make-list (list-length list) :initial-element #\Space)))
    (format nil "~{~A~}"
	    (mapcar #'(lambda (x) (setf (nth (nth x list) ret)
					(char str x)))
		    (range 0 (list-length list))))
    (coerce ret 'string)))

(progn
  (print (shuffle-string "lacelengh" '(3 2 0 5 4 8 6 7 1)))
  (print (shuffle-string "rulepark" '(4 7 3 1 0 5 2 6))))

