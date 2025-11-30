
(defun meeting (X P L)
    (if (car X)
        (let ((letter (car X)))
            (cond
             (
                (CHAR= letter #\U)
                 (let (
                       (new (list (car P) ( + (cadr P) 1) )))
                      (if (equal '(0 0) new)
                         t
                         (meeting (cdr X) new (cons new L))
                         )
                     )
             )
              (
                (CHAR= letter #\D)
                (let (
                       (new (list (car P) ( - (cadr P) 1) )))
                       (if (equal '(0 0) new)
                         t
                         (meeting (cdr X) new (cons new L))
                         )
                     )
              )  
             (
               (CHAR= letter #\L)
                (let (
                       (new (list (- (car P) 1)  (cadr P))))
                       (if (equal '(0 0) new)
                         t
                         (meeting (cdr X) new (cons new L))
                         )
                     )
             )
             (
               (CHAR= letter #\R)
                (let (
                       (new (list (+ (car P) 1)  (cadr P))))
                       (if (equal '(0 0) new)
                         t
                         (meeting (cdr X) new (cons new L))
                         )
                     )
             )
             (
              '()
             )
             )
            )
           nil
        )
    )



(loop for X in '("ULD" "ULDR" "UUURRRDDD" "UURRRDDLLL" "RRUULLDDRRUU" )
     collect
      (meeting (coerce X 'list) '(0 0) '())
     )

