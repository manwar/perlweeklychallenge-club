(setq arr (list 3 4 2))

(defun action (li)
  (if (= (first li) (apply #'min li))
      (rest li)
      (append (rest li) (list (first li)))))

;(defmacro while (condition &body body)
;  `(loop while ,condition do (progn ,@body)))

;(while (> (length arr) 0)
;(progn (setq arr (action arr)) (setq c (+ 1 c))))

(let ((c 0))
  (loop
     (setq arr (action arr))
     (incf c)
     (unless (> (length arr) 0)
         (print c)(return))))
