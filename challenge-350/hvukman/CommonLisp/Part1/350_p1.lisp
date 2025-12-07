(ql:quickload "fiveam")
(use-package :fiveam)

(defparameter test '( "abcaefg" "xyzzabc" "aababc" "qwerty" "zzzaaa"))


(defun allsame (X)
  (let ((inp (coerce X 'list)))
    (= (length inp) (length (remove-duplicates inp :test #'string=) ))
  )
)

(fiveam:test 350_test1
  (fiveam:is (equal '(5 3 1 4 0) 
    (loop for j in test
    collect
    (count T
      (loop for i from 0 to (- (length j) 3)
                collect
                  (allsame (subseq j i (+ i 3)))
                )
      )
    )
  )
  )
)


(fiveam:run! '350_test1)
