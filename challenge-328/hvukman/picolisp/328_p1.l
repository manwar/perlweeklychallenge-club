
(setq choose "abcdefghijklmnopqrstuvwxyz")

(de choose_letter (new after before)
    (if (and (not (= new after) ) (not (= new before))) 
         new
         (choose_letter (get (chop choose) (rand 1 26)) after before)
   )
)

(de new_str (X)
(pack (make
    (let list_str (chop X)
    (for N (size list_str) 
        (let (before (get list_str (- N 1)) after (get list_str (+ N 1)))
            (if (not (= (get list_str N) "?"))
                (link (get list_str N) )
                    (let new (get (chop choose) (rand 1 26))
                        (if (and (not (= new after) ) (not (= new before))) 
                            (link new )
                            (link (choose_letter (get (chop choose) (rand 1 26)) after before))
                        )
                    )
            )
        )   
    )
)
)
)
)

(println (new_str "a?z"))
(println (new_str "pe?k"))
(println (new_str "gra?te"))
