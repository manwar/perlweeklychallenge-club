(ns c198.t2)

(def DEFAULT-INPUT [10])
(def CERTAINTY 1000)

(defn prime-count
  [n]
  (let [f (fn [x]
            (when (.isProbablePrime (BigInteger/valueOf x) CERTAINTY) 1))]
    (transduce (keep f) + 0 (range n))))

(defn -main
  "Run Task 2 with a given input COLL, defaulting to the first example from
  the task description."
  [& args]
  (let [[n] (or (some->> args (map parse-long)) DEFAULT-INPUT)]
    (println (prime-count n))))
