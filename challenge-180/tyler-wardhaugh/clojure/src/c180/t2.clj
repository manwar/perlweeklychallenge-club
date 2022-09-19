(ns c180.t2
  (:require [clojure.edn :as edn]))

(def DEFAULT-INPUT [[1 4 2 3 5] 3])

(defn trim-list
  [coll n]
  (filter #(< n %) coll))

(defn -main
  "Run Task 2 with a given input N, defaulting to the first example from the
  task description."
  [& args]
  (let [[N I] (or (some->> args (map edn/read-string)) DEFAULT-INPUT)]
    (println (trim-list N I))))
