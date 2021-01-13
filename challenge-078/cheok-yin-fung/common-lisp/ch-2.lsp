; The Weekly Challenge - Perl & Raku #078 Task 2
; Common Lisp Script
; ref: https://stackoverflow.com/questions/16678371/circular-list-in-common-lisp
;    answered by Rainer Joswig

(setf *print-circle* t)  ; or the Lisp interpreter will crash IF
   ; it is required to handle the circular list

(setf mylist (list 10 20 30 40 50))
(setf list-len (length mylist))
(setf rotated-indices (list 3 4))

(defun circular (items)
  (setf (cdr (last items)) items)
    items)

(circular mylist)

(defun main (num-list)
  (dolist (x num-list) (progn
     (setf temp-list nil)
     (dotimes (i list-len)
       (push (nth (+ i x) mylist) temp-list))
       (nreverse temp-list) 
       (print temp-list))))

(main rotated-indices)
