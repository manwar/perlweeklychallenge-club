(ns tw.weekly.c86.t1
  (:require [clojure.edn :as edn]))

;;;
; Task description for TASK #1 › Pair Difference
;;;

(defn pair-difference
  "Find a pair of coll such that their difference equals the target"
  [target coll]
  (let [freqs (frequencies coll)
        s (-> freqs keys set)
        repeater (fn [v] (when v (repeat 2 v)))]
    (if (zero? target)
      (->> freqs (filter (fn [[_ v]] (> v 1))) ffirst repeater)
      (->> s (keep (fn [v] (let [k (+ target v)] (when (s k) [v k])))) first))))

(defn -main
  "Run Task 1 with a target A and a list of numbers N, defaulting to the
  first example given in the task description."
  [& args]
  (let [A (or (some->> args first edn/read-string) 7)
        N (or (some->> args rest (map edn/read-string)) [10 8 12 15 5])]
    (println (if (pair-difference A N) 1 0))))
