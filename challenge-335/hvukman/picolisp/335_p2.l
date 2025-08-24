
(setq magic_square  '( (4 9 2) (3 5 7) (8 1 6)) ) 

(de Winner (X)
    (if (<= 3 (length X))
        (let (score_a 0 score_b 0)
        
            (for Y (length X)
            
            (let (point (get X Y) point_x (get point 1) point_y (get point 2)
                  magic_square_x (get magic_square (+ 1 point_x))
                  magic_square_y (get magic_square_x (+ 1 point_y))
            )
                # magic_square_y as point to get from magic_square
            #     (println "point " point)
             #    (println "mpoint " magic_square_y)
            
            
            # every second move by b
            (if (= 0 (% Y 2))
               (setq score_b (+ score_b magic_square_y))
               (setq score_a (+ score_a magic_square_y))
            )
          #  (println "score_a " score_a)
          #  (println "score_b " score_b)
            (cond
            
            (
                (= score_a 15)
                'winnerA
            )
            (
                (= score_b 15)
                'winnerB
            )
            (
               (= Y (length X))
                'draw
            )
            
            
            )

            )

        )
        
        )
        'pending
    )

)

(setq games '( ( (0 0) (2 0) (1 1) (2 1) (2 2) )
        ( (0 0) (1 1) (0 1) (0 2) (1 2) (2 0))
        ((0 0) (1 1) (2 0) (1 0) (1 2) (2 1) (0 1) (0 2)  (2 2))
        ( (0 0 ) (1 1))
        ( (1 1) (0 0) (2 2) (0 1) (1 0) (0 2))
) )

(for X games
    (println (Winner X ))
)

# (load "perlpico/335_p2.l")  