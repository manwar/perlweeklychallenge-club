;(setf *line* '(1 4 3 2 5 2))
;(setf *K* 3)
(setf *line* '(5 6 3 2 7 9))
(setf *K* 6)

(setf *small* nil)
(setf *large* nil)

(defun newas (R)
      (append *small* (cons R nil))
)

(defun newal (R)
      (append *large* (cons R nil))
)

(defun biway (R)
   (if (> *K* R)
      (setf *small* (newas R ))
      (setf *large* (newal R ))
   )
)

(loop for R in *line*
   do (biway R)    
)

(print (append *small* *large*))

