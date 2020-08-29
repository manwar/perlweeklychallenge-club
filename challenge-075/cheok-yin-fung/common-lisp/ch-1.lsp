; Perl Weekly Challenge #075 Task 1 Coins Sum
; task statement:
; You are given a set of coins @C, assuming you have 
; infinite amount of each coin in the set.
; Write a script to find how many ways you make 
; sum $S using the coins from the set @C.
; Usage: (coins-sum (list $S @C))

(defun same-combination (l1 l2)
  (setf current T)
  (setf l2-car (car l2))
  (if (member l2-car l1) 
    (setf new-l1 (remove l2-car l1 :count 1))
    (setf current nil))
  (setf new-l2 (rest l2))
  (cond 
     ((equal current nil) nil)
     ((and (equal new-l1 nil) (equal new-l2 nil)) t)
     (t (same-combination new-l1 new-l2) ))
)

(setf *print-array* T)

(defun COINS-SUM (urinput)
    (setf COINS (rest urinput)
          TARGET (car urinput)
          ARR NIL )

;   initialize the array for dynamic programming
    (setf vec-for-dp (make-array (+ 1 TARGET) :initial-element NIL))


    (loop for i from 1 to TARGET
        do ( 
            if (some (lambda (x) (equal i x)) COINS) 
            (setf (aref vec-for-dp i) (list ( list i) ))))


    (loop for i from 1 to TARGET
        do ( dolist (element COINS)
               (setf temp (- i element))
               (if ( > temp 0) 
                   (progn  
                          (dolist (partition (aref vec-for-dp temp))
                            (setf newpartition 
                                    (append partition (list element)))
                               (if (NOTANY 
                                     (lambda (x) 
                                       (same-combination newpartition x)) 
                                    (aref vec-for-dp i) )
                                    (push newpartition (aref vec-for-dp i))
                                    ))))))

;   print the combinations of coins
    (format t (write-to-string (aref vec-for-dp target)))
;   print the answer
    (format t (write-to-string (length (aref vec-for-dp target))))
)



