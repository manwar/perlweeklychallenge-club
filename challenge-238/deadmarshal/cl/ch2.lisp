(defun digits (n)
  (map 'list #'digit-char-p (prin1-to-string n)))

(defun helper (acc n)
  (if (< n 10)
      acc
      (helper (1+ acc) (apply #'* (digits n)))))

(defun persistence-sort (list)
  (sort list #'(lambda (a b)
		 (let ((ha (helper 0 a))
		       (hb (helper 0 b)))
		   (if (/= ha hb)
		     (< ha hb)
		     (< a b))))))

(progn
  (print (persistence-sort '(15 99 1 34)))
  (print (persistence-sort '(50 25 33 22))))

