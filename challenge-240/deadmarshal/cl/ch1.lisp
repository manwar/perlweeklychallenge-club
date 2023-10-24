(defun acronym (list check)
  (let ((temp (loop :for s :in list
		    :collect (string-downcase (subseq s 0 1)))))
    (string= (format nil "~{~A~}" temp) check)))

(progn
  (print (acronym '("Perl" "Python" "Pascal") "ppp"))
  (print (acronym '("Perl" "Raku") "rp"))
  (print (acronym '("Oracle" "Awk" "C") "oac")))

