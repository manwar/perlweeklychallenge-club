(defun sorted-digits (n)
  "Sorted list of the digits of n"
  (sort (mapcar
	 'string-to-number (split-string (number-to-string n) "" t)
	 )
	'<))
(defun eqlist (nl ml)
  "Check if two lists are equal"
  (cond
   ((null nl) (null ml))
   ((eq (car nl) (car ml)) (eqlist (cdr nl) (cdr ml)))))
(defun check-multiplier (n m)
  "Check if n and n*m have the same digits"
  (let* ((r (* m n)) (nl (sorted-digits n)) (rl (sorted-digits r)))
    (eqlist nl rl)))
(defun permuted-multiples (n)
  "Check if the number n has permuted multiples"
  (let
      ((m 2) (success t))
    (while (and (<= m 6) success)
      (setq success (check-multiplier n m))
      (setq m (+ m 1)))
    success))
(defun search ()
  "Search integers from 1 onward looking for permuted multiples"
  (let ((n 0)(found nil))
    (while (not found)
      (setq n (+ n 1) found (permuted-multiples n)))
    n))
;; Run the search and print the result
(print (search))
