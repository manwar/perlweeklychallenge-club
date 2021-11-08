(ns tw.weekly.c138.t1
  (:require [clojure.edn :as edn]))

;;;
; Task description for TASK #1 › Workdays
;;;
(def DEFAULT-INPUT [2021])

(defn -main
  "Run Task 2 with a given input N, defaulting to the first example from the
  task description."
  [& args]
  (let [[N] (or (some->> args (map edn/read-string)) DEFAULT-INPUT)]
    ))
