;; tested with sbcl --script ch-1.lsp 5 2 1 4 3

;;; Comment:
;; I thought (sort x #'<) is sorted in place of x
;; however, it didn't work properly until I did (setq x (sort x #'<))


(defun get-command-line ()
  (or
   #+CLISP *args*
   #+SBCL *posix-argv*
   #+LISPWORKS system:*line-arguments-list*
   #+CMU extensions:*command-line-words*
   nil))

(defparameter *cmdline* (get-command-line))

(defun print-usage ()
  (format t "Usage: sbcl --script ch-1.lsp <integer> ..."))

(when (< (length *cmdline*) 1) (print-usage) (quit))

(defparameter *integer-list* (map 'list #'parse-integer (rest *cmdline*)))

;; (solution ...)
(let ((p (reduce #'* *integer-list*)))
  (format t "~A~%" (map 'list #'(lambda (x) (/ p x)) *integer-list*)))

(quit)
