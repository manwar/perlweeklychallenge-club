(defn zero-friend [nums]
    (min (map abs nums))
)

(print (zero-friend [4 2 -1 3 -2]))
(print (zero-friend [-5 5 -3 3 -1 1]))
(print (zero-friend [7 -3 0 2 -8]))
(print (zero-friend [-2 -5 -1 -8]))
(print (zero-friend [-2 2 -4 4 -1 1]))
