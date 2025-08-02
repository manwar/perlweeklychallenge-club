 (setq inp "the1weekly2challenge2")

 (de fun (X)
    (make
        (for N (chop X)
        
            (if (format N)
                (link N)
                (link "")
            )
        )
    )
    
 )

 # (load "perlpico/329_p1.l")

(de do_it (X)
    (make
    (for N (size X)
        (if (format (get X N)) 
            (let dummy
            (link (make
                (while (and (<= N (size X)) (format (get X N))) 
                    (let new (get X N) 
                        (prinl new)
                        (link new )
                        (setq N (inc N))
                    )
                )
                
                #(setq N (inc N)) 
                #(prinl "dummy " dummy)    
                #(link dummy)
              ) 
            )
            )
        )
        #(prinl (made))
    )
    )
)

(setq inp (fun inp))
(do_it inp)

(setq inp2 "go21od1lu5c7k")
(do_it (fun inp2))
