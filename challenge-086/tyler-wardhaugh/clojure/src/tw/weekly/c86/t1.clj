(ns tw.weekly.c86.t1
  (:require [clojure.edn :as edn]))

;;;
; Task description for TASK #1 › Pair Difference
;;;

(defn pair-difference
  "Find a pair of coll such that their difference equals the target"
  [target coll]
  (let [xf (if (zero? target)
             (keep (fn [[k v]] (when (> v 1) k)))
             (map key))
        s (into #{} xf (frequencies coll))]
    (->> s (filter #(s (+ target %))) first)))

(defn -main
  "Run Task 1 with a target A and a list of numbers N, defaulting to the
  first example given in the task description."
  [& args]
  (let [A (or (some->> args first edn/read-string) 7)
        N (or (some->> args rest (map edn/read-string)) [10 8 12 15 5])]
    (println (if (pair-difference A N) 1 0))))
