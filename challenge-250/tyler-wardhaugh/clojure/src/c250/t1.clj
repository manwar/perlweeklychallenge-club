(ns c250.t1
  (:require
    [clojure.edn :as edn]))

(def DEFAULT-INPUT [[0 1 2]])

(defn smallest-index
  [coll]
  (or
    (->> coll
         (keep-indexed (fn [i v] (when (== v (mod i 10)) i)))
         first)
    -1))

(defn -main
  "Run Task 1 with a given input COLL, defaulting to the first example from the
  task description."
  [& args]
  (let [[COLL] (or (some->> args (map edn/read-string)) DEFAULT-INPUT)]
    (println (smallest-index COLL))))
