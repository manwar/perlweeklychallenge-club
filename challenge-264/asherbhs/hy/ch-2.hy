(import hyrule *)

(defn target-array [source indices] (do
  (setv target [])
  (for [[x i] (zip source indices)] (target.insert i x))
  target
))

(pprint (target-array [0 1 2 3 4] [0 1 2 2 1]))
(pprint (target-array [1 2 3 4 0] [0 1 2 3 0]))
(pprint (target-array [1]         [0]))

