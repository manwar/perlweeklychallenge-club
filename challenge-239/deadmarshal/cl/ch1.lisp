(defun same-string (list1 list2)
  (let ((s1 (format nil "~{~A~}" list1))
	(s2 (format nil "~{~A~}" list2)))
    (string= s1 s2)))

(progn
  (print (same-string '("ab" "c") '("a" "bc")))
  (print (same-string '("ab" "c") '("ac" "b")))
  (print (same-string '("ab" "cd" "e") '("abcde"))))

