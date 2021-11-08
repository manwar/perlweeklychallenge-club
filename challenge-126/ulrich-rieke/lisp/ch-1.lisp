#!/usr/bin/sbcl --script

(defun solution( n )
(loop for i from 1 to n counting ( zerop ( count #\1 ( format nil "~d" i )))))

(format t "~d~%" (solution 15))
