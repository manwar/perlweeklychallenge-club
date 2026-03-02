(defun main (args)
  (loop for word in args do
    (challenge-362-1 word)))

(defun challenge-362-1 (word)
  (loop for i from 1
        for c across word do
    (princ (make-string i :initial-element c)))
  (terpri))

; Adjust for other common lisp implementations
(main (cdr #+SBCL *posix-argv*))