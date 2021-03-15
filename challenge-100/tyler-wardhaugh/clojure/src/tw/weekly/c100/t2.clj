(ns tw.weekly.c100.t2
  (:require [clojure.edn :as edn]))

;;;
; Task description for TASK #2 › Triangle Sum
;;;

(def DEFAULT-INPUT [ [1], [2,4], [6,4,9], [5,1,7,2] ])

(defn min-row
  "For a row of length n, generate n-1 numbers representing the pair of
  each element in row with its right neighbor."
  [coll]
  (let [xf (map (partial reduce min))
        source (partition 2 1 coll)]
    (sequence xf source)))

(defn min-triangle-sum
  "Find the mininum path sum for the triangle from top to bottom."
  [t]
  (let [f (fn [acc row] (map + (min-row acc) row))]
    (->> (reverse t)
         (reduce f)
         first)))

(defn -main
  "Run Task 2 using a triangle T, defaulting to the example given in the
  task description."
  [& args]
  (let [T (or (some-> args first edn/read-string) DEFAULT-INPUT)]
    (println (min-triangle-sum T))))
