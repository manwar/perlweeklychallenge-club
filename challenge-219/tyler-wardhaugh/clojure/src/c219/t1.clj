(ns c219.t1
  (:require
    [clojure.edn :as edn]
    [clojure.math.numeric-tower :refer [expt]]))

(def DEFAULT-INPUT [[-2 -1 0 3 4]])

(defn sorted-squares
  [coll]
  (->> coll (map #(expt % 2)) sort))

(defn -main
  "Run Task 1 with a given input COLL, defaulting to the first example from the
  task description."
  [& args]
  (let [[coll] (or (some->> args (map edn/read-string)) DEFAULT-INPUT)]
    (println (sorted-squares coll))))
