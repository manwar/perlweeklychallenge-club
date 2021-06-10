#!/usr/bin/sbcl --script

(defun theNumbers ( )
(let ((nums (list 0 1)))
  (dotimes (j 48)
  (if (evenp ( + 2 j ))
    (setf nums ( append nums ( list (elt nums (/(+ 2 j) 2) ) )))
    (setf nums ( append nums ( list (+ (elt nums (floor (/ (+ 2 j ) 2 )) )
                    (elt nums (+ (floor (/ ( + 2 j ) 2 )) 1) )))))))
  ( write nums )))

(theNumbers)
