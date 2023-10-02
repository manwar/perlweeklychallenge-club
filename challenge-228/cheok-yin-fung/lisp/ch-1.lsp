(setq arr (list 2 1 1 3 4 ))

(defun test (item)
  (= (position item arr) (- (length arr) (position item (reverse arr)) 1 )))

(reduce '+ (remove-if-not #'test arr))
