(ns c188.t1
  (:require [clojure.edn :as edn]
            [clojure.math.combinatorics :as combo]))

(def DEFAULT-INPUT ['(4, 5, 1, 6) 2])

(defn divisible-pairs
  [coll k]
  (let [source (-> coll (combo/combinations 2))
        xf (keep (fn [[x y]] (when (zero? (rem (+ x y) k)) 1)))]
    (transduce xf + source)))

(defn -main
  "Run Task 1 with a given input LIST and K, defaulting to the first example
  from the task description."
  [& args]
  (let [[LIST K] (or (some->> args (map edn/read-string)) DEFAULT-INPUT)]
    (println (divisible-pairs LIST K))))
