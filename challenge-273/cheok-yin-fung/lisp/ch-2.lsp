; The Weekly Challenge 273
; Task 2 B After A

(defun c-b-after-a (word)
  (cond
    ((null (exist-b word)) nil)
    (t (searchq "a" (subseq word (search "b" word))))))

(defun searchq (alpha word)
  (cond
    ((null (search alpha word)) -1)
    (t (search alpha word))))

(defun b-after-a (word)
  (and (exist-b word) (cond ((equalp -1 (c-b-after-a word)) 't) (t 'nil)))))

