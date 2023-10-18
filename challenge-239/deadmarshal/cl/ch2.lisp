(defun consistent-strings (list allowed)
  (let ((count 0))
    (loop :for e :in list
	  :do (if (every #'(lambda (c) (position c allowed)) e)
		  (incf count)))
    count))

(progn
  (print (consistent-strings
	  '("ad" "bd" "aaab" "baa" "badab") "ab"))
  (print (consistent-strings
	  '("a" "b" "c" "ab" "ac" "bc" "abc") "abc"))
  (print (consistent-strings
	  '("cc" "acd" "b" "ba" "bac" "bad" "ac" "d") "cad")))

