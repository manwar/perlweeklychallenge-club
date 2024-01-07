(defun smallest-index (list)
  (loop :for i :from 0 :below (list-length list)
	:do (when (= (mod i 10) (nth i list))
	      (return-from smallest-index i)))
  -1)

(progn
  (print (smallest-index '(0 1 2)))
  (print (smallest-index '(4 3 2 1)))
  (print (smallest-index '(1 2 3 4 5 6 7 8 9 0))))

