(defun running-sum (list)
   (loop :for e :in list :sum e :into s :collect s))

(progn
  (print (running-sum '(1 2 3 4 5)))
  (print (running-sum '(1 1 1 1 1)))
  (print (running-sum '(0 -1 1 2))))

