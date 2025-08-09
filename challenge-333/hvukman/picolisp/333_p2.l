
(de dup (Z)
# link with made until length of z 
(make
(for X (size Z)
    (T (< (- (size Z) 1) (size (made)) )  (println (made)) )
    (cond 
        (
        (= 0 (get Z X))
            # insert 0 twice if 0 and does not excede length og input z
            (link 0)
            (if (> (size Z) (size (made)) ) 
                (link 0)
            )       
        )
        (T 
            (link (get Z X))
        )
    )
)
    (println (made))
)
)

(setq inp (list '(1 2 3) '(1 2 3 0) '(0 0 1 2) '(1 2 0 0 3)))

(for X inp
    (dup X)
)

# (load "perlpico/333_p2.l") 
