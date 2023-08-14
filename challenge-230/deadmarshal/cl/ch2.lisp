(ql:quickload :str)

(defun count-words (list pat)
  (let ((count 0))
    (mapcar #'(lambda (x) (when (str:starts-with-p pat x) (incf count)))
	    list)
    count))

(progn
  (print (count-words '("pay" "attention" "practice" "attend") "at"))
  (print (count-words '("janet" "julia" "java" "javascript") "ja")))

