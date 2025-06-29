(de flatten (X)
    (fish atom X) )


(de mad (arg)
(car (filter '( (X) (< 0 X)) (sort (uniq (flatten (make 
    (for XX arg 
        (link (mapcar '( (x) (abs (- XX x))  ) arg) ) 
    )
    )
    )
    )
    ))
)
)

(setq inp (4 1 2 3))
(setq list_mad (mad inp))
(println "MAD: " list_mad)

(setq 'ZZ NIL)

(de sol (X)
(make
 (for x X
        (for y X
            (if (= list_mad (abs (- x y) )) 
                    (let (dummy NIL key1 (sym x) key2 (sym y))
                         
                         #(println (get 'ZZ key1))
                         #(println (get 'ZZ key2))
                        (cond
                         (
                            (and  (= NIL (get 'ZZ key1)) (= NIL (get 'ZZ key2 )))
                            
                            (put 'ZZ key2 x)
                            #(println (list x y))
                            #(println "@ " (mapcar car (made)))
                            (if (= NIL (member y (flatten (mapcar car (made)))))
                                (link (list x y))
                            )
                            
                         )
                         (T  )
                        )
                    )
            )
        )
    )
)
)
    

(println (sol inp))

(setq inp (1 3 7 11 15))
(setq list_mad (mad inp))
(println "MAD: " list_mad)
(setq 'ZZ NIL)
(println (sol inp))

(setq inp (1 5 3 8))
(setq list_mad (mad inp))
(println "MAD: " list_mad)
(setq 'ZZ NIL)
(println (sol inp))