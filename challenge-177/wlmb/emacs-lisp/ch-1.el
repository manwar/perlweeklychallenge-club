 ;; Perl weekly challenge 177
 ;; Task 1: Damm algorithm

 ;; See https://wlmb.github.io/2022/08/08/PWC177/#task-1-damm-algorithm


(defun show-damm (n)
  "Print if string of digits n is correct by applying Damm's algorithm"
  (princ (format "%s %s correct " n (if (test-damm n) "is" "isn't"))))
(defun test-damm (n)
  "Test string of digits n for Damm-correctness"
  (equal 0(test-damm1 (cons 0 (mapcar 'string-to-number(split-string n "" t))))))
(defun test-damm1 (s)
  "Test the sequence of digits s for Damm-correctness"
  (cl-reduce (lambda (i j)(aref2 table i j)) s))
(defun aref2 (table i j)
  "Access 2D table with two indices"
  (aref (aref table i) j))
(let
    (
     (table				; Damm table
      (vconcat
       (mapcar
	(lambda(x)
	  (vconcat
	   (mapcar 'string-to-number (split-string x "" t))))
	'("0317598642" "7092154863" "4206871359" "1750983426" "6123045978"
          "3674209581" "5869720134" "8945362017" "9438617205" "2581436790"))))
     (candidates '("5724" "5727")))	; examples to test
     (mapc 'show-damm candidates))
