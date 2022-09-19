(ns c182.t1
  (:require [clojure.edn :as edn]))

(def DEFAULT-INPUT ['(5, 2, 9, 1, 7, 6)])

(defn max-index
  "Find the index of the maximum value."
  [coll]
  (->> coll (map-indexed vector) (apply max-key second) first))

(defn -main
  "Run Task 1 with a given input N, defaulting to the first example from the
   task description."
  [& args]
  (let [[N] (or (some->> args (map edn/read-string)) DEFAULT-INPUT)]
    (println (max-index N))))
