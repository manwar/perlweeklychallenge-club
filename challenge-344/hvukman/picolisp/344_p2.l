# for permutations
(load "@lib/simul.l")

(de flatten (Lst)
    (fish atom Lst) 
)

# map get over flattened permutations
# see if target is member
(de arrayformation (X Y)
    (if
        (member X 
            (make
                (for Y (mapcar flatten (permute Y))
                (link 
                (make (for Z (length Y)
                        (link (get Y Z))
                    )
                )
                )
                )
            )
        )
        'true
        'false
    )
)

(arrayformation '(1 2 3 4) '( (2 3 ) (1) (4)))
(arrayformation '(1 2 3 4) '( (1 3 ) ( 2 4) ))
(arrayformation '(5 8 2 9 1) '( (9 1 ) ( 5 8 ) (2) ))
(arrayformation '(1 2 3) '( ( 1 ) (3 )  ))
(arrayformation '(7 4 6) '( ( 7 4 6 )  ))


