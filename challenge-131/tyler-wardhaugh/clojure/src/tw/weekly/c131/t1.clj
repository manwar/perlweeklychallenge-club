(ns tw.weekly.c131.t1
  (:require [clojure.edn :as edn]
            [clojure.pprint :refer [cl-format]]))

;;;
; Task description for TASK #1 › Consecutive Arrays
;;;
(def DEFAULT-INPUT [[1 2 3 6 7 8 9]])

(defn partition-by-prev
  "Similar to partition-by, partition coll when f returns a new value, where f expects the previous
  element and the current one."
  [f coll]
  (let [source (->> (map f coll (rest coll))
                    (reductions not= true)
                    (map list coll))
        xf (comp (partition-by second)
                 (map (partial map first)))]
    (sequence xf source)))

(defn split-consecutive
  "Partition coll into contiguous groups of integers increasing by 1."
  [coll]
  (partition-by-prev #(not= %1 (dec %2)) coll))

(defn -main
  "Run Task 1 with a given input N, defaulting to the first example from the
  task description."
  [& args]
  (let [[N] (or (some->> args (map edn/read-string)) DEFAULT-INPUT)]
    (cl-format true "(~{[~{~a~^, ~}]~^, ~})~%" (split-consecutive N))))
