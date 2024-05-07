(import
  hyrule    *
  itertools *
)

(defn number-game [ints] (lfor
  #(x y) (batched (sorted ints) 2)
  z      #(y x)
  z
))

(print (number-game [2 5 3 4]))
(print (number-game [9 4 1 3 6 4 6 1]))
(print (number-game [1 2 2 3]))
