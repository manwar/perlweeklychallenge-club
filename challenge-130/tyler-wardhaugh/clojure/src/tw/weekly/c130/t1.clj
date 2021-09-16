(ns tw.weekly.c130.t1
  (:require [clojure.edn :as edn]))

;;;
; Task description for TASK #1 › Odd Number
;;;
(def DEFAULT-INPUT [[2 5 4 4 5 5 2]])

(defn odd-one-out
  [coll])

(defn -main
  "Run Task 1 with a given input N, defaulting to the first example from the
  task description."
  [& args]
  (let [[N] (or (some->> args (map edn/read-string)) DEFAULT-INPUT)]
    (println (odd-one-out N))))
