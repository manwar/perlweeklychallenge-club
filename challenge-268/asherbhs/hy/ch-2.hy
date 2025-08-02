(import
  hyrule    *
  itertools *
)

(require hyrule *)

(defn number-game [ints] (as-> ints it
  (sorted it)
  (batched it 2)
  (map reversed it)
  (chain.from-iterable it)
  (list it)
))

(pprint (number-game [2 5 3 4]))
(pprint (number-game [9 4 1 3 6 4 6 1]))
(pprint (number-game [1 2 2 3]))
