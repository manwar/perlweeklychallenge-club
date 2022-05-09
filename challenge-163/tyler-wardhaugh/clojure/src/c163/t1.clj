(ns c163.t1
  (:require [clojure.edn :as edn]
            [clojure.math.combinatorics :as combo]))

(def DEFAULT-INPUT [[1 2 3]])

(defn sum-bitwise
  [coll]
  (let [source (combo/combinations coll 2)
        xf (map (partial apply bit-and))]
    (transduce xf + 0 source)))

(defn -main
  "Run Task 1 with a given input N, defaulting to the first example from the
  task description."
  [& args]
  (let [[N] (or (some->> args (map edn/read-string)) DEFAULT-INPUT)]
    (println (sum-bitwise N))))
