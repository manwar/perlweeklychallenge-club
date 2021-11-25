(ns tw.weekly.c140.t2
  (:require [clojure.edn :as edn]))

;;;
; Task description for TASK #2 › Multiplication Table
;;;
(def DEFAULT-INPUT [2 3 4])

(defn -main
  "Run Task 2 with a given input I J K, defaulting to the first example from
  the task description."
  [& args]
  (let [[I J K] (or (some->> args (map edn/read-string)) DEFAULT-INPUT)]
    ))
