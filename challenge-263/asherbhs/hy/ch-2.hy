(import collections)

(defn merge-items [items1 items2] (do
  (setv merged (collections.defaultdict int))
  (for [[i n] (+ items1 items2)]
    (+= (get merged i) n)
  )
  (list (map list (merged.items)))
))

(print (merge-items
  [[1 1] [2 1] [3 2]]
  [[2 2] [1 3]]
))
(print (merge-items
  [[1 2] [2 3] [1 3] [3 2]]
  [[3 1] [1 3]]
))
(print (merge-items
  [[1 1] [2 2] [3 3]]
  [[2 3] [2 4]]
))
