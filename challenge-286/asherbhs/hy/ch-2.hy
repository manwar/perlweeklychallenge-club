(require hyrule [as-> do-n fn+])

(import itertools [batched])
(import math      [log])

(defn order-game [ints] (do
    (do-n
        (int (log (len ints) 2))
        (setv ints (as-> ints them
            (enumerate them)
            (batched them 2)
            (map
                (fn+ [[[i x] [_ y]]]
                    ((if (= 0 (% i 4)) min max) x y)
                )
                them
            )
        )
    ))
    (next ints)
))

(print (order-game [2 1 4 5 6 3 0 2]))
(print (order-game [0 5 3 2]))
(print (order-game [9 2 1 4 5 6 0 7 3 1 3 5 7 9 0 8]))
