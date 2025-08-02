(defn target-index [ints k] (lfor
  [i n] (enumerate (sorted ints))
  :if (= n k)
  i
))

(print (target-index [1 5 3 2 4 2] 2))
(print (target-index [1 2 4 3 5]   6))
(print (target-index [5 3 2 4 2 1] 4))
