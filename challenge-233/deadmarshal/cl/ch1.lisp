(defun similar-words (list)
  (let ((ht (make-hash-table :size (list-length list))))
    (mapcar #'(lambda (s) (incf (gethash
			    (remove-duplicates (sort s #'char-lessp))
			    ht 0)))
	    list)
    (print ht)
    (loop :for v :being :the :hash-value :of ht
	  :do (print (/ (* v (1- v)) 2)))))

(progn
  (print (similar-words '("aba" "aabb" "abcd" "bac" "aabc")))
  (print (similar-words '("aabb" "ab" "ba")))
  (print (similar-words '("nba" "cba" "dba"))))

