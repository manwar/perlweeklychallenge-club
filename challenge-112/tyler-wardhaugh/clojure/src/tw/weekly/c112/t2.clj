(ns tw.weekly.c112.t2
  (:require [clojure.edn :as edn]))

;;;
; Task description for TASK #2 › Climb Stairs
;;;
(def DEFAULT-INPUT 3)

(def fib-seq
  (map first (iterate (fn [[a b]] [b (+ a b)]) [0 1])))

(defn climb-stairs
  "Find the distinct ways to climb n stairs, taking either 1 or 2 steps at a
  time."
  [n]
  (->> n inc (nth fib-seq)))

(defn -main
  "Run Task 2 with a given input N, defaulting to the first example from the
  task description."
  [& args]
  (let [N (or (some-> args first edn/read-string) DEFAULT-INPUT)]
    (println (climb-stairs N))))
