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
  (cl-loop for m from 2 to 6 for success = t then (check-multiplier n m)
    until (not success) finally return success))
(defun search ()
  "Search integers from 1 onward looking for permuted multiples"
  (cl-loop
    for n from 1 for found = nil then (permuted-multiples n)
      until found finally return n))
;; Run the search and print the result
(print (search))
