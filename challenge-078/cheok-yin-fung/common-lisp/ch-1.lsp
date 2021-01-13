; The Weekly Challenge - Perl & Raku #078 Task 1
; Common Lisp script

(setf mylist (list 9 10 7 5 6 1))

(setf *max* -10000)

(setf ans nil)

(setf rmylist (reverse mylist))

(dolist (x rmylist) (progn
  (setf s (pop rmylist))
  (if (> s *max*) (progn 
    (setf *max* s)
    (push s ans)))))

(print ans)
