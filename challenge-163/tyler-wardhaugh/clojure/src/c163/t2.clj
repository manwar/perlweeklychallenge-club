(ns c163.t2
  (:require [clojure.edn :as edn]))

(def DEFAULT-INPUT [[1 2 3 4 5]])

(defn summations
  [coll]
  (loop [coll coll]
    (if (< 1 (count coll))
      (recur (reductions + (drop 1 coll)))
      (first coll))))

(defn -main
  "Run Task 2 with a given input N, defaulting to the first example from the
  task description."
  [& args]
  (let [[N] (or (some->> args (map edn/read-string)) DEFAULT-INPUT)]
    (println (summations N))))
