(setf n 20)
(setf seq () )
(setf peak_eles ())
(setf range 50)
(make-random-state)

(loop for i from 1 upto n do
  (setf seq (cons (random range) seq))
)

(setf seq2 seq)


(setf x (cadr seq2))
(setf nm2 (- n 2))

(loop for i from 1 upto nm2 do
  (setf a (car seq2))
  (setf b (caddr seq2))
  (if (AND (< a x) (< b x)) (setf peak_eles (cons x peak_eles)) () )
  (setf seq2 (cdr seq2) )
  (setf x (cadr seq2) )
  (setf l (length seq2) )
)

(setf peak_eles (reverse peak_eles))

seq   ; the sequence given
peak_eles   ; peak elements
