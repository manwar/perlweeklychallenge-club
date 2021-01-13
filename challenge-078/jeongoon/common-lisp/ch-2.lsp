(defun left-rotate (lst n)
  (loop for e in lst
        for i from 0
        if (< i n) collect e into backs
        else collect e into fronts
        finally (return (concatenate 'list fronts backs))))

(defun map-left-rotate (lst n-list)
  (map 'list (lambda (n) (funcall #'left-rotate lst n)) n-list))

(defun get-command-line ()
  (or
   #+CLISP *args*
   #+SBCL *posix-argv*
   #+LISPWORKS system:*line-arguments-list*
   #+CMU extensions:*command-line-words*
   nil))

(defparameter *cmdline* (get-command-line))

(defun print-usage ()
  (format t "Usage: sbcl --script ch-1.lsp <integer> ... / <unsigned integer> ..."
          (first *cmdline*)))
(when (< (length *cmdline*) 5) (print-usage) (quit))

(defparameter *sep* nil)
(defparameter *a-array* '())
(defparameter *b-array* '())

;; ref: http://clhs.lisp.se/Body/05_abc.htm
(setf (values *a-array* *b-array*)
  (loop for arg in (rest *cmdline*)
        for n = (parse-integer arg :junk-allowed t)
        if (null n) do (when (null *sep*) (setq *sep* arg))
        else if (null *sep*) collect arg into a-array
             else collect n into b-array
        finally (return (values a-array b-array))))

(format t "@A = ~a~%" *a-array*)
(format t "@B = ~a~%" *b-array*)
(loop for rotated in (map-left-rotate *a-array* *b-array*)
      do (format t "~a~%" rotated))
