(defun zero-array (list)
  (let ((dedup (remove-duplicates
		(remove-if (lambda (x) (zerop x)) list))))
    (list-length dedup)))

(progn
  (print (zero-array '(1 5 0 3 5)))
  (print (zero-array '(0)))
  (print (zero-array '(2 1 4 0 3))))

