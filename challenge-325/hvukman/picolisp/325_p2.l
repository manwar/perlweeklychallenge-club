


(de rebates (XX) 
(for (I . X) prices 
    (let (curr X pos (+ I 1) rebate)
        (prinl "current: " curr)
        (while (and
            (= rebate NIL)
            (<= pos (size prices)) 
        )
        #(println "pos " pos)
        (cond 
        ( (<= (get prices pos) curr)
            
                (prinl "price with rebate: ")
                (println (- curr (get prices pos)))
                (setq rebate T)
        )
         (T  
                (setq pos (inc pos))
                #(prinl 'no_rebate)
                #(println pos) 
         ) 
        )
        )
        (if (= rebate NIL)
            (prinl "no rebate; price: " curr)
        )
    )
    )
)

(prinl "example one" )
(set 'prices '(8 4 6 2 3))
(rebates 'prices)
(prinl "example two" )
(set 'prices '(1 2 3 4 5))
(rebates 'prices)
(prinl "example three" )
(set 'prices '(7 1 1 5))
(rebates 'prices)
