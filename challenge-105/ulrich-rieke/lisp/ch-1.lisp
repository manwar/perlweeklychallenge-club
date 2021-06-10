#!/usr/bin/sbcl --script
(defun myRoot (n k )
(expt k (/ 1 n)))

(format t "~f~%" (myRoot 5 34))
