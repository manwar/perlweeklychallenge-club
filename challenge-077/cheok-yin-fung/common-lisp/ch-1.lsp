; The Weekly Challenge - Perl & Raku #077 
;   Task 1 Fibonacci Sum
; Lisp script

(defun vequalp (s1 s2) 
  (and (subsetp s1 s2) (subsetp s2 s1)))


(defun anyeq (x y)
   (cond ((null x) nil)
         ((vequalp y (first x)) t)
         (t (anyeq (rest x) y ))))


(setf *N* 80)

(setf *counter* 1)

(setf *FIBSEQ* (list 1 1))


(defun larger-fib-num ()
   (setf tempseq (reverse *FIBSEQ*))
   (cond ((>= (first tempseq) *N* ) nil)
         (t (progn 
              (push (+ (first tempseq) (second tempseq) ) tempseq)
              (setf *FIBSEQ* (reverse tempseq)) 
              (larger-fib-num) ))))

(larger-fib-num)

(setf *copy-fibseq* (reverse *FIBSEQ*))

(setf *firstsum* () )

(defun greedy (target)
   (cond  
       ((= target 0) nil)
       ((>= target (first *copy-fibseq*)) (progn 
         (setf tempitem (first *copy-fibseq*))                               
         (pop *copy-fibseq*)
         (push (length *copy-fibseq*) *firstsum*)
         (greedy (- target tempitem ) )))
        ((< target (first *copy-fibseq*)) (progn 
            (pop *copy-fibseq*) (greedy target)))))

(greedy *N*)

(setf *answer* (list (reverse *firstsum*)) )

(defun is-a-new-discovery (thelist)
    (if (anyeq *answer* thelist)
      ()
      (progn  
        (nconc *answer* (list thelist))
        (incf *counter*))))

(defun a-loop (oldanswer)
    (if (equal *counter* 0) () (progn
        (setf a-list (car oldanswer))
        (setf *counter* 0)
        (expand-one-by-one a-list)
        (lasttwo a-list)
        (lastone a-list)
        (setf oldanswer (rest oldanswer))
        (a-loop oldanswer))))

(defun expand (k uinput) 
  (setf TTBR (nth k uinput) )
  (if  
    (or (equal (nth (+ 1 k) uinput ) (- TTBR 1) )
         (equal (nth (+ 1 k) uinput ) (- TTBR 2) ))
     ()
     (progn  
        (setf newlist (remove TTBR uinput ) ) 
        (setf newlist (cons (- TTBR 1) newlist ) )
        (setf newlist (cons (- TTBR 2) newlist ) )
        (sort newlist '>)
        (is-a-new-discovery newlist))))

(defun lastone (uinput)
  (if (> (length uinput) 0) (progn
    (setf TTBR (nth (- (length uinput) 1) uinput ))
    (if (> TTBR 2)
            (progn  
                (setf newlist (remove TTBR uinput ) ) 
                (setf newlist (cons (- TTBR 1) newlist ) )
                (setf newlist (cons (- TTBR 2) newlist ) )
                (sort newlist '>)
                (is-a-new-discovery newlist))))))

(defun lasttwo (uinput)
  (if (> (length uinput) 1) (progn
    (setf TTBR (nth (- (length uinput) 2) uinput ))
    (if 
        (and (> TTBR 2) 
             (> (- TTBR 2) (nth (- (length uinput) 1 ) uinput)))
        (progn  
            (setf newlist (remove TTBR uinput ) ) 
            (setf newlist (cons (- TTBR 1) newlist ) )
            (setf newlist (cons (- TTBR 2) newlist ) )
            (sort newlist '>)
            (is-a-new-discovery newlist))))))

(defun expand-one-by-one (urinput)
   (dotimes (j (- (length urinput) 2))
       (expand j urinput)))

(a-loop *answer*)

(format T "number of summation(s)~%" )
(format T (write-to-string (length *answer*)))
(format t "~%")
(dolist (a-seq *answer*)
  (print (mapcar #'(lambda (term) (nth term *fibseq*)) a-seq))
  (format T "~%"))
