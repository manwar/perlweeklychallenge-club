#!/usr/bin/sbcl --script

(defun solution( n )
(do
  (( p (+ 1 n) (+ 1 p ))
  (ones ( count #\1 (format nil "~b" n ))))
  ((= ones (count #\1 (format nil "~b" p ))) p )))

;examples from the task
(format t "~d~%" ( solution 3 ))
(format t "~d~%" ( solution 12))
