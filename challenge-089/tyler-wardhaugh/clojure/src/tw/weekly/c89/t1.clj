(ns tw.weekly.c89.t1
  (:require [clojure.edn :as edn])
  (:require [clojure.math.combinatorics :as combo])
  (:require [clojure.math.numeric-tower :as math]))

;;;
; Task description for TASK #1 › GCD Sum
;;;

(defn gcd-sum
  "Sum of the GCD of all possible unique pairs between 1 and n."
  [n]
  (let [xf (map (partial apply math/gcd))]
    (transduce xf + (-> (range 1 (inc n)) (combo/combinations 2)))))

(defn -main
  "Run Task 1 with a list of numbers N, defaulting to the
  first example given in the task description."
  [& args]
  (let [N (or (some-> args first edn/read-string) 3)]
    (println (gcd-sum N))))
