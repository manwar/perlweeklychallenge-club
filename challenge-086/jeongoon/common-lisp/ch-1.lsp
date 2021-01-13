;; tested with sbcl --script 15 20 -15 0 30

(defun get-command-line ()
  (or
   #+CLISP *args*
   #+SBCL *posix-argv*
   #+LISPWORKS system:*line-arguments-list*
   #+CMU extensions:*command-line-words*
   nil))

(defparameter *cmdline* (get-command-line))

(when (< (length *cmdline*) 3) (print-usage) (quit))

(defun print-usage ()
  (format t "Usage: sbcl --script ch-1.lsp <target diff(positive integer)> <integer> ..."))

(defparameter *integer-list* (map 'list #'parse-integer (rest *cmdline*)))
(defvar target-diff (first *integer-list*))

(when (< target-diff 0) (print-usage) (quit))

(defvar int-list (rest *integer-list*))
(sort int-list #'<)       ;; sort in place

(defvar found nil)

;; (solution ...)
(loop for int-vec = (coerce (rest int-list) 'vector)
      for left-val = (first int-list)
      do(if (or found (null left-val))
            (return)
          ;; else
          (loop for right-val across int-vec
                do(let ((df (- right-val left-val)))
                    (if (= df target-diff)
                        (progn (format t "1 as ~A - ~A = ~A~%"
                                       right-val left-val target-diff)
                               (setq found t)
                               (return))
                      (when (> df target-diff)
                        ;; no meaning go foward: move left value by
                        ;; shifting (cdr, or rest)
                        (setq int-list (rest int-list))
                        (return))))
                finally (setq int-list (rest int-list)))))

(when (null found) (format t "0"))
