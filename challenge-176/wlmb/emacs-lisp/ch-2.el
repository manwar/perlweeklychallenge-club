(defun odd-digits (n)
  "Check that n has only odd digits"
  (cond
   ((null n) t)
   ((= (% (car n) 2) 1) (odd-digits (cdr n)))
   (t nil)))
(defun digits (n)
  "List of digits of n"
  (mapcar 'string-to-number (split-string(number-to-string n) "" t)))
(defun reverse-digits (n)
   "Number with the digits of n in reversed order"
   (string-to-number(reverse(number-to-string n))))
(defun is-reversible (n)
  "n is a reversible number"
  (odd-digits (digits (+ n (reverse-digits n)))))
;; search and print reversible numbers below 100
(print (cl-loop for n from 10 below 100 append (if (is-reversible n) (list n) '())))
