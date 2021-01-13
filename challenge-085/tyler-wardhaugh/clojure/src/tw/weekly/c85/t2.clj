(ns tw.weekly.c85.t2
  (:require [clojure.edn :as edn])
  (:require [clojure.math.numeric-tower :as math]))

;;;
; Task description for TASK #2 › Power of Two Integers
;;;

(defn logN
  "Compute the log of x in base y."
  [x y]
  (/ (Math/log x) (Math/log y)))

(defn has-power-expr
  "Find one or more [a b] such that n = a ^ b where a > 0 and b > 1. If no
  expression is possible, nil is returned."
  [n]
  (let [endpoint (fn [x] (inc (math/floor (logN n x))))
        combos (for [a (range 2 (endpoint 2))
                     b (range 2 (endpoint a))]
                 (math/expt a b))]
    (->> combos (filter (partial = n)) first)))

(defn -main
  "Run Task 2 with a positive integer, defaulting to the example given in the task description."
  [& args]
  (let [N (or (some-> args first edn/read-string) 8)
        result (has-power-expr N)]
    (println (if result 1 0))))
