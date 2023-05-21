(ns c217.t1
  (:require
    [clojure.edn :as edn]))

(def DEFAULT-INPUT [[[3 1 2] [5 2 4] [0 1 3]]])

(defn third-smallest-of-sorted-matrix
  [coll]
  (let [sorted (->> coll (mapcat identity) sort)]
    (nth sorted 2)))

(defn -main
  "Run Task 1 with a given input COLL, defaulting to the first example from the
  task description."
  [& args]
  (let [[coll] (or (some->> args (map edn/read-string)) DEFAULT-INPUT)]
    (println (third-smallest-of-sorted-matrix coll))))
