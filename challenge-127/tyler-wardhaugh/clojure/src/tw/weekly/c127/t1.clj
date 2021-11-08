(ns tw.weekly.c127.t1
  (:require [clojure.edn :as edn]
            [clojure.set :as set]))

;;;
; Task description for TASK #1 › Disjoint Sets
;;;
(def DEFAULT-INPUT ['(1, 2, 5, 3, 4) '(4, 6, 7, 8, 9)])
 
(defn disjoint?
  [s1 s2]
  (empty? (set/intersection (set s1) (set s2))))

(defn -main
  "Run Task 1 with a given input S1 and S2, defaulting to the first example
  from the task description."
  [& args]
  (let [[S1 S2] (or (some->> args (map edn/read-string)) DEFAULT-INPUT)]
    (println (if (disjoint? S1 S2) 1 0))))
