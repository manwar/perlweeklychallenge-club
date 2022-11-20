(ns c191.t1
  (:require [clojure.edn :as edn]))

(def DEFAULT-INPUT [[1 2 3 4]])

(defn twice-largest
  [coll]
  (let [[biggest second-biggest] (sort > coll)]
    (when (and biggest second-biggest)
      (<= (* 2 second-biggest) biggest))))

(defn -main
  "Run Task 1 with a given input COLL, defaulting to the first example from
  the task description."
  [& args]
  (let [[COLL] (or (some->> args (map edn/read-string)) DEFAULT-INPUT)]
    (println (if (twice-largest COLL) 1 -1))))
