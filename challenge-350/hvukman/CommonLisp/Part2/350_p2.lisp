(ql:quickload "fiveam")
(use-package :fiveam)

(defun same-digits (X Y)
     (equal (sort (mapcar #'parse-integer 
            (mapcar #'string (numtolist X))) #'<)
     (sort (mapcar #'parse-integer 
            (mapcar #'string (numtolist Y)) ) #'<)
    ))

(defun numtolist (X)
     (coerce (format nil "~A" X) 'list) 
         )

(defun shuffle (X Y)
    (let (
          (end (length (numtolist X)))
          )
        (loop for i fixnum from 2
            when (same-digits X (* X i)) 
                  collect i into return-list
                while                  
                 (<= (length (numtolist (* X i))) end) 
                finally (if (= Y (length return-list))
                          (return return-list)
                          NIL
                        )
        )
    )
)

(defun shufflepairs (X Y target)
  (loop for i from X to Y
      when (shuffle i target)
          collect 
              i into return-list
          finally 
          (return return-list)
  )
)

(fiveam:test 350_test2
  (fiveam:is (equal NIL (shufflepairs 1 1000 1)))
  (fiveam:is (equal 3 (length (shufflepairs 1500 2500 1))))
  (fiveam:is (equal 2 (length (shufflepairs 1000000 1500000 5))))
  (fiveam:is (equal 2 (length (shufflepairs 1030 1130 1))))
  (fiveam:is (equal 5 (length (shufflepairs 13427000 14100000 2) )))
)

(fiveam:run! '350_test2)




