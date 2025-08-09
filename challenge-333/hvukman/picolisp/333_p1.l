(de dummy (X)
    (mapcar * X 100000)
)

(setq inp 
        (list (list (2 1) (2 3) (2 5) ) (list (1 4) (3 4) (10 4) )
        (list (0 0) (1 1) (2 3) )
        (list (1 1) (1 1) (1 1) )
         (mapcar dummy (list (1 1) (2 2) (3 3) ))
        )
)

## caluclated the determinant between line 1, line 2 and 1 1 1
(de straight (X)
(let 
    (P1 (get X 1) P2 (get X 2) P3 (get X 3)
    x1 (get P1 1) x2 (get P2 1)
    x3 (get P3 1)
    y1 (get P1 2) y2 (get P2 2)
    y3 (get P3 2)
     )
        (if (= 0 
        ( + (sum + (mapcar (quote (X) (apply * X )) 
        (list (list x1 y2 ) (list x2 y3 ) (list x3 y1 ))))
        (sum - (mapcar (quote (X) (apply * X )) 
        (list (list x1 y3 ) (list x2 y1 ) (list x3 y2 )))))
        )
        (println 'true)
        (println 'false)
        )
)
)


(for X inp
    (straight X)
)

#(load "perlpico/333_p1.l")
