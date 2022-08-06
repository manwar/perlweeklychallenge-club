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
;; search for reversible numbers below 100
(let ((n 10) (result '()))
  (while (< n 100)
    (if (is-reversible n)
	(setq result (cons n result)))
    (setq n (+ n 1)))
  (print (reverse result)))
