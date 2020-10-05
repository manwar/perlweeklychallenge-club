; The Weekly Challenge - Perl & Raku #080 Task 1 Smallest Positive Integer
; Common Lisp script

(setf arr (list 1 8 -1) )
(setf *N* (length arr))
(setf int-seq (list (+ *N* 1))) 

(dotimes (i *N*)
   ( push (- *N* i) int-seq)  )    ; int-seq == 1, 2, 3, 4, .. N+1

(format t "Given a list:" )
(print arr)
(format t ", the smallest positive integer hasn't appeared:")
(print (nth 0 (set-difference int-seq arr)))
