(ql:quickload "str")

(defun max-words (list)
  (apply #'max (mapcar #'(lambda (s) (list-length (str:words s)))
		       list)))

(progn
  (print (max-words '("Perl and Raku belong to the same family."
		      "I love Perl."
		      "The Perl and Raku Conference.")))
  (print (max-words '("The Weekly Challenge."
		      "Python is the most popular guest language."
		      "Team PWC has over 300 members."))))

