;; a non-recursive combination modified for challenge
(defun make-vector-range (min max)
  (let* ((range (loop for i from min to max collect i))
         (size (length range)))
    (make-array (list size) :initial-contents range)))

(defun combinations (n m)
  ;; a non-recursive method for making combinations
  (when (>= m n)
    (let* ((initial-room-size (- m n))
           (room (make-array (list n) :initial-element initial-room-size))
           (num  (make-array (list n)
;;                             :initial-contents (make-vector-range 0 (1- n))))
                             :initial-contents (make-vector-range 1 n)))
           (next-cursor (1- n))
           (combi (list (coerce num 'list)))) ;; coerce makes a copy of array
      (loop named moving-element do
            (if (> (aref room next-cursor) 0)
                ;; still current element move to right
                (let ((ref-room (aref room next-cursor))
                      (ref-num  (aref num  next-cursor)))
                  (setf (aref room next-cursor) (1- ref-room))
                  (setf (aref num  next-cursor) (1+ ref-num))
                  (nconc combi (list (coerce num 'list))))
              ;; else
              ;; no more room left on the right for current element
              ;; have to move cursor to point next avaiable one.
              (let*
                  ((cursor-moved
                    (loop named moving-cursor for i from next-cursor above 0
                          do
                          (when (> (aref room (1- i)) 0)
                            (setq next-cursor (1- i))
                            (return-from moving-cursor t)))))
                (if cursor-moved
                    (let ((room-size (1- (aref room next-cursor)))
                          (base-num  (aref num next-cursor)))
                      (loop for i from next-cursor below n
                            for p from 1 do
                            (progn
                              (setf (aref room i) room-size)
                              (setf (aref num  i) (+ base-num p))))
                      (nconc combi (list (coerce num 'list)))
                      (setq next-cursor (1- n)))
                  ;; else : "no more movement" means we found all combinations
                  (return-from moving-element combi))))))))

(defun get-command-line ()
  (or
   #+CLISP *args*
   #+SBCL *posix-argv*
   #+LISPWORKS system:*line-arguments-list*
   #+CMU extensions:*command-line-words*
   nil))

(defparameter *cmdline* (get-command-line))

(defun print-usage ()
  (format t "Usage: sbcl --script ch-1.lsp <$m> <$n>"
          (first *cmdline*)))

(when (< (length *cmdline*) 3) (print-usage) (quit))
(defparameter *maximum-natnum* (parse-integer (second *cmdline*)))
(defparameter *num-selection*  (parse-integer (third *cmdline*)))

(format t "~a~%" (combinations *num-selection* *maximum-natnum*))
