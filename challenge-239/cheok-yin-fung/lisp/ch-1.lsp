(equalp (concatenate 'string "ab" "c") (concatenate 'string "a" "bc"))

(defun ss (arr1 arr2)
  (equalp (format nil "~{~A~^~}" arr1) (format nil "~{~A~^~}" arr2)
))

(ss (list "a" "bc") (list "ab" "c"))
(ss (list "ab" "c") (list "ac" "b"))
(ss (list "ab" "cd" "e") (list "abcde"))

