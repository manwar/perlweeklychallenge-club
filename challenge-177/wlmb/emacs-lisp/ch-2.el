 ;; Perl weekly challenge 177
 ;; Task 2: Palyndromic prime cyclops

 ;; See https://wlmb.github.io/2022/08/08/PWC177/#task-2-palindromic-prime-cyclops
(defun cyclops (how-many)
 (cl-loop
  for left from 1 				; danger: no guard
  for left-string = (number-to-string left)
  for has0 = (string-match "0" left-string)
  for candidate = (string-to-number(concat left-string "0" (reverse left-string)))
  for prime = (car (math-prime-test candidate 1))
  for success = (and (not has0) prime)
  for count = 0 then (if success (+ count 1) count)
  while (< count how-many)
  if success
  collect candidate ))
(princ (cyclops 20))
