; The Weekly Challenge 278
; Task 2 Reverse Word

(defun searchq (alpha word)
  (cond
    ((null (search alpha word)) -1)
    (t (search alpha word))))

(defun reord-word (word alpha)
  (format nil "~{~A~}" 
    (list 
      (sort (copy-seq (subseq word 0 (+ 1 (searchq alpha word)))) #'char-lessp)
      (subseq word (+ 1 (searchq alpha word)) (length word)))))


; > (reord-word "challenge" "e")
; "acehllnge"
; > (reord-word "programming" "a")
; "agoprrmming"
; > (reord-word "champion" "b")
; "champion"

