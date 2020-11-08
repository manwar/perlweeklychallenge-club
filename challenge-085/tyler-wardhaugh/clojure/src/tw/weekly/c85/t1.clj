(ns tw.weekly.c85.t1
  (:require [clojure.math.combinatorics :as combo])
  (:require [clojure.edn :as edn]))

;;;
; Task description for TASK #1 › Triplet Sum
;;;

(defn find-triplet-sum
  "Find a triplet such that 1 < a+b+c < 2. If found, return the smallest
  sum, otherwise nil."
  [coll]
  (let [lower 1, upper 2, num-items 3
        expand (fn [[e cnt]] (repeat (min num-items cnt) e))
        v (->> coll (filter (partial > upper)) frequencies (mapcat expand))]
    (->> (combo/permuted-combinations v num-items)
         (map (partial reduce +))
         (filter #(< lower % upper))
         first)))

(defn -main
  "Run Task 1 with an list of positive real numbers R, defaulting to the
  first example given in the task description."
  [& args]
  (let [R (or (some->> args (map edn/read-string)) [1.2 0.4 0.1 2.5])]
    (println (if (find-triplet-sum R) 1 0))))
