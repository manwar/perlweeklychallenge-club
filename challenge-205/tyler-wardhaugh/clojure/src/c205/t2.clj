(ns c205.t2
  (:require
    [clojure.edn :as edn]))

(def DEFAULT-INPUT [[1 2 3 4 5 6 7]])

(defn max-xor
  [coll]
  (let [uniq (set coll)
        xors (for [x uniq
                   y (drop 1 uniq)]
               (bit-xor x y))]
    (apply max xors)))

(defn -main
  "Run Task 2 with a given input COLL, defaulting to the first
  example from the task description."
  [& args]
  (let [[coll] (or (some->> args (map edn/read-string)) DEFAULT-INPUT)]
    (println (max-xor coll))))
