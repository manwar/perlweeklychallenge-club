; The Weekly Challenge 258
; Task 1 Count Even Digits Number

(defun cedn (lst) (reduce #'+ (mapcar (lambda (r) (mod (+ 1 (length (write-to-string r))) 2)) lst)))

;> (cedn '(10 1 111 24 1000))
;3

