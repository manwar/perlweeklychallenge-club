(import hyrule [pprint])

(defn bitwise-or [ints]
  (>=
    (sum (gfor n ints (= (% n 2) 0)))
    2
  )
)

(pprint (bitwise-or [1 2 3 4 5]))
(pprint (bitwise-or [2 3 8 16]))
(pprint (bitwise-or [1 2 5 7 9]))
