(ql:quickload "fiveam")
(use-package :fiveam)
(defun power_string (X l &optional (i 1))
    (if (< 1 (length X))
        (let* (
        
        (letter (car X))  
        (sec_letter (cadr X))
        
        )
         (if (char= letter sec_letter)
            (power_string  (cdr X) l (+ i 1))
            (let ((j i))
                 (power_string  (cdr X) (cons j l) )   
                    )
            )
        )
        (cond
         ( (< 1 i)
            (cons i l)
         )
         (
          (equal '() l)
             (cons i l)
         )
         (             
            l
         )
            
            )
        )
)
    
(loop for X in '( "textbook"  "aaaaa" "hoorayyy" "x"  "aabcccddeeffffghijjk")
            collect
           (reduce #'max 
                (power_string (coerce X 'list) '())
                )
          )

(fiveam:test read-file-as-string-normal-file
  (let ((result (read-file-as-string "/tmp/hello.txt")))
    ;; Tip: put the expected value as the first argument of = or equal, string= etc.
    ;; FiveAM generates a more readable report following this convention.
    (is (string= "hello" result))))
    
(reduce #'max values)
