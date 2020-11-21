; The Weekly Challenge - Perl & Raku #087 
; Task 1: Longest Consecutive Sequence
; Common Lisp script

(setf *ans* '(10000))

(defun add1 (mynumber)
  (+ 1 mynumber))


(defun seperate-list ()
  (if (not (zerop (length *mylist*))) (progn (progn
    (if (= (add1 (car *mylist*)) (car (car *newlist*)))
      (push (car *mylist*) (car *newlist*))
      (push (nreverse (list (car *mylist*))) *newlist*))
    (setf *mylist* (cdr *mylist*))
    (print *mylist*)
    (print *newlist*)
    (seperate-list)))))

(defun extract-longest ()
  (if (>=  (length *mylist*) 1 ) (progn
    (if (> (length (car *mylist*)) (length *ans*))
      (setq *ans* (car *mylist*)))
    (setq *mylist* (cdr *mylist*))
    (extract-longest))))

; ================================================
; main procedures

;example; (setf *mylist* '(50 48 301 4 51 3 2 49 29 300))
(setf *mylist* '(50 48 301 4 51 3 2 49 29 300))
(sort *mylist* #'>)
; (example)  *mylist* is (2 3 4 29 48 49 50 51 300 301)

(setf *newlist* (list (list (car *mylist*))))
(setf *mylist* (cdr *mylist*))
(seperate-list)
(setf *mylist* *newlist*)
; (example) *mylist is ((2 3 4) (29) (48 49 50 51) (300 301))

(extract-longest)

(if (= (length *ans*) 1) 
  (print 0) 
  (progn 
    (format t "~%") 
    (format t "Answer:") 
    (print *ans*)))


