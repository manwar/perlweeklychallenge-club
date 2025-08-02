(import hyrule [pprint])

(defn distribute-elements [ints] (do
  (setv
    arr1 [(get ints 0)]
    arr2 [(get ints 1)]
  )
  (for [n (cut ints 2 None)]
    (if (> (get arr1 -1) (get arr2 -1))
      (arr1.append n)
      (arr2.append n)
    )
  )
  (+ arr1 arr2)
))

(pprint (distribute-elements [2 1 3 4 5]))
(pprint (distribute-elements [3 2 4]))
(pprint (distribute-elements [5 4 3 8]))

