;; tested with: sbcl --script ch-1.lsp 9 10 7 5 6 1

(defun leader-element (numbers)
  (if (null numbers) '(0)
    ;; else
    (let* ((rnumbers (reverse numbers))
           (cur-leader (1- (apply #'min numbers)))) ;; pseudo first leader
      (reverse
       (loop for leader in
             (map 'list (lambda (c) ;; (c)andidate
                          (if (<= cur-leader c)
                              (progn (setq cur-leader c) c) nil)) rnumbers)
             if (not (null leader)) collect leader)))))

(defun get-command-line ()
  (or
   #+CLISP *args*
   #+SBCL *posix-argv*
   #+LISPWORKS system:*line-arguments-list*
   #+CMU extensions:*command-line-words*
   nil))

(defparameter *cmdline* (get-command-line))

(defun print-usage ()
  (format t "Usage: sbcl --script ch-1.lsp <integer> ..." (first *cmdline*)))
(when (< (length *cmdline*) 1) (print-usage) (quit))

(defparameter *numbers*
  (remove-if #'null ;; filtering non-integer values ...
             (map 'list (lambda (n-str) (parse-integer n-str :junk-allowed t))
                         (rest *cmdline*))))

(format t "@A = ~a~%" *numbers*)
(format t "@B = ~a~%" (leader-element *numbers*))
