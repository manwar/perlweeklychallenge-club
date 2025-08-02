(defun lucky-integer (lst)
    (setq len (length lst))
    (setq freq (make-array (+ 1 len) :initial-element 0))
    (dotimes (i len)                           
        (setf (aref freq (nth i lst)) (+ 1 (aref freq (nth i lst)))))
    (setq rfreqlst (coerce (reverse freq) 'list))
    (setq arr (loop for y from 0 to len
        until (= (nth y rfreqlst) (- len y))
        collect (- len y)))
    (setq ans (- (first (reverse arr)) 1))
    (cond ((= ans 0)
        (setq ans -1)
    ))
    ans)


(lucky-integer (list 2 2 3 4))     ;  2
(lucky-integer (list 1 2 2 3 3 3)) ;  3
(lucky-integer (list 1 1 1 3))     ; -1

