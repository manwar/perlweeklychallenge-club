; Perl Weekly Challenge #075 Task 2 Largest Rectangle Histogram
; task statement: 
; https://perlweeklychallenge.org/blog/perl-weekly-challenge-075/

(setf ARR (list 3 2 3 5 7 5))




(defun largest (a)
    (if (> (length a) 2)
        (max (first a) (largest (rest a)))
        (if (= (length a) 2) (max (first a) (cadr a)) (car a) ))
)


(defun smallest (a)
    (if (> (length a) 2)
        (min (first a) (smallest (rest a)))
        (if (= (length a) 2) (min (first a) (cadr a)) (car a) ))
)

(defun subtract1 (A)
  (mapcar #'(lambda (term) (if (zerop term) (quote 0) (- term 1)  )  ) 
     A ))


(defun generate-pos-in-line (line) 
  (setf pos-in-line nil)
  (setf temp nil)
  (loop for i from 0 to (- (length ARR) 1) do
     (if (zerop (nth i line)) 
         (progn (setf temp (reverse temp)) (if (not (not temp)) (push temp pos-in-line)) (setf temp nil) ) 
         (push i temp))
  )
  (if (not (not temp)) (push temp pos-in-line) ())
  pos-in-line
)


(setf maxARR (largest ARR))
(setf minARR (smallest ARR))


(setf twoD nil)
(push ARR twoD)
(loop for i from 0 to (- maxARR 1) do
      (setf temp-line (subtract1 (first twoD)))
      (push temp-line twoD)
)


(setf *maxarea* (* (smallest ARR) (length ARR) ))


(setf *current-height* maxARR)

(setf already-computed-poss nil)



(defun blck (diagram-index)
  (mapcar #'(lambda (arg) (nth arg (nth (- *current-height* 1) twoD))) diagram-index ))

(defun testmax-from-pos ( diagram-index )
  (setf area-of-blck (* (length diagram-index) *current-height* ))
  (if (not (member diagram-index already-computed-poss :test #'equal)) 
    (progn    
      (if ( > area-of-blck *maxarea* ) (setf *maxarea* area-of-blck)
      )
      (push diagram-index already-computed-poss)
  )))



(loop for i from 1 to (- maxARR minARR) do
  (dolist (poss (generate-pos-in-line (nth i twoD))) 
     (testmax-from-pos poss))
  (decf *current-height*)
  )

(format t "answer: ")
(format t (write-to-string *maxarea*))
(format t "~%")
(format t "~%")

(defun print-histogram ()
    (format t '"histogram~%" )

    (loop for h from 1 to maxARR do
      (format t (write-to-string (+ (- maxARR h) 1) ))
      (format t " ")
      (loop for i from 0 to (- (length ARR) 1) do
        (if (equal 0 (nth i (nth h twoD) )) 
            (format t "  ")
            (format t "# "))
       )
    (format t "~%")
    )


    (loop for i from 1 to (length ARR) do
      (format t "_ ") 
       )
       (format t "_ ~%")

       (format t "  ")
       (dolist (n ARR)
         (format t (write-to-string n))
         (format t " ")
       )
)


(print-histogram)
