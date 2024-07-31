; The Weekly Challenge 278
; Task 1 Sort String

; https://cl-cookbook.sourceforge.net/strings.html
 (defun split-by-one-space (string)
    (loop for i = 0 then (1+ j)
          as j = (position #\Space string :start i)
          collect (subseq string i j)
          while j))

(defun parse-int (str) (parse-integer str :start (search (write-to-string (some #'digit-char-p str)) str) :end (length str)))
(defun parse-alpha (str) (subseq str 0 (search (write-to-string (some #'digit-char-p str)) str)))

(defun ord-lst (lst-a &aux result)
  (setf result (make-array (length lst-a)))
  (dolist (x lst-a result)
    (setf (aref result (- (parse-int x) 1)) (parse-alpha x))))

(defun sort-string (original-sentence)
  (format nil "~{~A~^ ~}" (coerce (ord-lst (split-by-one-space original-sentence)) 'list)))

