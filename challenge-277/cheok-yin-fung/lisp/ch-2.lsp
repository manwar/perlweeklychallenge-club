; The Weekly Challenge 277
; Task 2 Strong Pair

(defun strong-pair (lst-a &aux result)
  (dolist (x (remove-duplicates lst-a) result)
    (dolist (y (remove-duplicates lst-a))
      (when (and (< 0 (- y x)) (not (equal x y)) (< (- y x) (min x y)))
        (push (list x y) result)))))

(defun strong-pair-cnt (lst-a)
  (length (strong-pair lst-a)))

; > (strong-pair (list 1 2 3 4 5))
; ((4 5) (3 5) (3 4) (2 3))
; > (strong-pair-cnt (list 1 2 3 4 5))
; 4

; > (strong-pair (list 5 7 1 7 ))
; ((5 7))
; > (strong-pair-cnt (list 5 7 1 7 ))
; 1

