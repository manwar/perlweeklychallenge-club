(setq words '( '("bella" "label" "roller") '("cool" "lock" "cook") ))

(de flatten (Lst)
    (fish atom Lst) )

(de common (XX) 
(setq chars (uniq (flatten (mapcar chop XX))))
 (for Y chars
   # (println "char " Y)
    (make 
        (for X XX
           (let dummy (filter (quote (Z) (= Z Y )) (chop X))
            (if dummy
                (link (size dummy))
            )
           )
        )       
       
        (cond
        ( (= (size (made)) (size XX))
            (for Z (car (made))
                (print Y " ")
            ) 
            (println "")
        )
        )
            
    )
    
)
)
    
(for X words
    (common X)
)


# (load "perlpico/335_p1.l")   
