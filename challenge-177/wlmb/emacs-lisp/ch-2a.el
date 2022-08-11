# Perl weekly challenge 177
# Task 2: Palyndromic prime cyclops
#
# See https://wlmb.github.io/2022/08/08/PWC177/#task-2-palindromic-prime-cyclops
(defun cyclops (how-many)
 (let ((left 1)(count 0)(result nil))
   (while (< count how-many)
     (let ((left-string (number-to-string left)))
       (unless (string-match "0" left-string)
	 (let ((cyclops (string-to-number(concat left-string "0" (reverse left-string)))))
	   (when (car (math-prime-test cyclops 1))
	     (setq result (cons cyclops result))
	     (setq count (+ count 1))))))
     (setq left (+ left 1)))
   (reverse result)))
(print (cyclops 20))
