#!/usr/bin/sbcl --script

(defun solution (theList)
(let ((sorted (sort theList #'> )))
(if (= (length theList) 1)
  0
  (loop for i from 0 to (- (length theList) 2) maximizing (- (elt sorted i )
                              (elt sorted (+ i 1 )))))))

(solution (list 5))
(solution ( list 2 9 3 5 ))
