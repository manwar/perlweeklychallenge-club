(defun split-words (input)
  (let ((i (position #\space input)))
    (cond
      ((zerop (length input)) nil)
      ((null i) (list input))
      ((zerop i) (split-words (subseq input 1)))
      (t (cons (subseq input 0 i) (split-words (subseq input (1+ i))))))))

(defun join (seperator l)
  (cond
    ((null l) "")
    ((null (cdr l)) (format nil "~A" (first l)))
    (t (format nil "~A~A~A" (first l) seperator (join seperator (cdr l))))))

(defun main (input)
  (let ((nums (map 'list #'parse-integer
                (split-words
                  (substitute #\space #\(
                    (substitute #\space #\)
                      (substitute #\space #\, input)))))))
    (format t "(~A)~%"
      (join ", "
        (sort
          nums
          (lambda (a b) (string-lessp (to-words a)
          (to-words b))))))))

(defun to-words (num &optional (show-zero t))
  ; Yes, this is ugly, but it does work!
  (string-trim '(#\space)
    (cond
      ((< num 0) (format nil "minus ~A" (to-words (- num))))
      ((>= num 1000000000000)
        (format nil "~A trillion ~A"
          (to-words (truncate num 1000000000000))
          (to-words (mod num 1000000000000) nil)))
      ((>= num 1000000000)
        (format nil "~A billion ~A"
          (to-words (truncate num 1000000000))
          (to-words (mod num 1000000000) nil)))
      ((>= num 1000000)
        (format nil "~A million ~A"
          (to-words (truncate num 1000000))
          (to-words (mod num 1000000) nil)))
      ((>= num 1000)
        (format nil "~A thousand ~A"
          (to-words (truncate num 1000))
          (to-words (mod num 1000) nil)))
      ((>= num 100)
        (format nil "~A hundred ~A"
          (to-words (truncate num 100))
          (to-words (mod num 100) nil)))
      ((and (> num 20) (> (mod num 10) 0))
        (format nil "~A-~A"
          (to-words (- num (mod num 10)))
          (to-words (mod num 10) nil)))
      ((= 90 num) "ninety")
      ((= 80 num) "eighty")
      ((= 70 num) "seventy")
      ((= 60 num) "sixty")
      ((= 50 num) "fifty")
      ((= 40 num) "fourty")
      ((= 30 num) "thirty")
      ((= 20 num) "twenty")
      ((= 19 num) "nineteen")
      ((= 18 num) "eighteen")
      ((= 17 num) "seventeen")
      ((= 16 num) "sixteen")
      ((= 15 num) "fifteen")
      ((= 14 num) "fourteen")
      ((= 13 num) "thirteen")
      ((= 12 num) "twelve")
      ((= 11 num) "eleven")
      ((= 10 num) "ten")
      ((= 9 num) "nine")
      ((= 8 num) "eight")
      ((= 7 num) "seven")
      ((= 6 num) "six")
      ((= 5 num) "five")
      ((= 4 num) "four")
      ((= 3 num) "three")
      ((= 2 num) "two")
      ((= 1 num) "one")
      ((= 0 num) (if show-zero "zero" ""))
      (t (format nil "~D" num)))))

; Adjust for other common lisp implementations
(main (format nil "~{~A ~}" (cdr #+SBCL *posix-argv*)))