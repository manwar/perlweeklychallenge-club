(ns tw.weekly.c85.t1
  (:require [clojure.edn :as edn]))

;;;
; Task description for TASK #1 › Triplet Sum
;;;

(defn find-triplet-sum
  "Find a triplet such that 1 < a+b+c < 2. If found, return the smallest
  sum, otherwise nil."
  [coll]
  (let [<=lower? (partial >= 1)
        <upper? (partial > 2)
        v (->> coll (filter <upper?) sort vec)]
    (->> (range (- (count v) 2))
         (map #(reduce + (subvec v % (+ % 3))))
         (drop-while <=lower?)
         (take-while <upper?)
         first)))

(defn -main
  "Run Task 1 with an list of positive real numbers R, defaulting to the
  first example given in the task description."
  [& args]
  (let [R (or (some->> args (map edn/read-string)) [1.2 0.4 0.1 2.5])]
    (println (if (find-triplet-sum R) 1 0))))
