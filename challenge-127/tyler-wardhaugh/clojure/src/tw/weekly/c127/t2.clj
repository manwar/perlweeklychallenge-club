(ns tw.weekly.c127.t2
  (:require [clojure.edn :as edn]
            [clojure.pprint :refer [cl-format]]))

;;;
; Task description for TASK #2 › Conflict Intervals
;;;
(def DEFAULT-INPUT ['[ (1,4), (3,5), (6,8), (12, 13), (3,20) ]])

(defn overlaps?
  "Does the interval [a b] conflict with the interval [n m]?"
  [[n m] [a b]]
  (or (< n b) (> a m)))

(defn conflict-intervals
  "Determine the conflict intervals in coll."
  [coll]
  (->
    (fn [overlaps i v]
      (transduce (comp (take i) (filter (partial overlaps? v))) 
                 (completing (fn [overlaps _] (reduced (conj overlaps v))))
                 overlaps
                 coll))
    (reduce-kv [] coll)))

(defn -main
  "Run Task 2 with a given input, defaulting to the first example from the
  task description."
  [& args]
  (let [[I] (or (some->> args (map edn/read-string)) DEFAULT-INPUT)]
    (cl-format true "[ ~{(~{~a~^,~})~^, ~} ]~%" (conflict-intervals I))))
