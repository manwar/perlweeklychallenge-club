#!/usr/bin/sbcl --script

(defun solution ( n )
(let (( numberstring ( format nil "~b" n ))
      ( reversed ))
  (setq reversed ( reverse numberstring ))
  (if (string=  numberstring reversed)
  1
  0)))

(format t "~d~%" (solution 4))
(format t "~d~%" (solution 5 ))
