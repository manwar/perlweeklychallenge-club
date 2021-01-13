; Perl Weekly Challenge #072 Task 1 Sliding Windows
; task statement:
; You are given an array of integers @A and sliding window size $S.
; Write a script to create an array of min from each sliding window.

( defun smallest (a)
    (if (> (length a) 2)
        (min (first a) (smallest (rest a)))
        (min (first a) (cadr a))
    )
)

(setf INPUT (list 1 5 0 2 9 3 7 6 4 8)
      B INPUT)

(setf S 3
      ANS ()
      window ()
)


; initialization of the variable window
(setf window (list (first INPUT)))
(loop for i from 1 to (- S 1)
   do (setf window (append window (list (nth i INPUT))))
)

(loop for i from 0 to (- (length INPUT) S ) do
      (setf ANS (append ANS (list (smallest window))  )
            B (rest B)
            window (append (rest window) (list (nth (- S 1) B)))
    )
)

ANS
