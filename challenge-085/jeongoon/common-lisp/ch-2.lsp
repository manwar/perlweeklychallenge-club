;; tested with:
;; sbcl --script ch-2.lsp 152306056642756
(defun get-command-line ()
  (or
   #+CLISP *args*
   #+SBCL *posix-argv*
   #+LISPWORKS system:*line-arguments-list*
   #+CMU extensions:*command-line-words*
   nil))

(defparameter *cmdline* (get-command-line))

(defun print-usage ()
  (format t "Usage: sbcl --script ch-2.lsp <a positive integer>"
          ;;(first *cmdline*)
          ))

(when (not (= (length *cmdline*) 2)) (print-usage) (quit))
(defparameter *target* (parse-integer (second *cmdline*)))

;; special case
(when (= *target* 1)  (format t "1 as 1^2")  (quit))

(defvar *max-power-factor* (isqrt *target*))

(loop for a from *max-power-factor* above 1
      do(let* ((b (floor (log *target* a)))
               (c (expt a b)))
          (when (= c *target*) ;; problem with log precision
                               ;; need to check directly.
            (format t "1 as ~d^~d = ~d~%" a b *target*)
            (quit))))

(format t "0")
