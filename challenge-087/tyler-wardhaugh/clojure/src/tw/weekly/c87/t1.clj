(ns tw.weekly.c87.t1
  (:require [clojure.edn :as edn])
  (:require [clojure.set :as set])
  (:require [clojure.pprint :refer [cl-format]]))

;;;
; Task description for TASK #1 › Longest Consecutive Sequence
;;;

(defn find-lcs
  "Find the longest consecutive sequence (with 2 or more elements)"
  [coll]
  (loop [s (set coll)
         lcs-diff 0
         lcs [0 0]]
    (if (empty? s)
      lcs
      (let [elem (first s)
            low (last (take-while s (iterate dec elem)))
            high (last (take-while s (iterate inc elem)))
            diff (- high low)]
        (if (and (not (zero? diff)) (> diff lcs-diff))
          (recur (set/difference s (set (range low (inc high)))) diff [low high])
          (recur (set/difference s #{elem}) lcs-diff lcs))))))

(defn -main
  "Run Task 1 with a list of numbers N, defaulting to the
  first example given in the task description."
  [& args]
  (let [N (or (some->> args (map edn/read-string)) [100 4 50 3 2])
       [low high] (find-lcs N)]
    (cl-format true "~{~a~^, ~}" (range low (inc high)))))
