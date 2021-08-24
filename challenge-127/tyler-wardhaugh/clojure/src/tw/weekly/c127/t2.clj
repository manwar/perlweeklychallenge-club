  (:require [clojure.edn :as edn]))
(ns tw.weekly.c127.t2

;;;
; Task description for TASK #2 › Conflict Intervals
;;;
(def DEFAULT-INPUT [])

(defn -main
  "Run Task 2 with a given input, defaulting to the first example from the
  task description."
  [& args]
  (let [[I] (or (some->> args (map edn/read-string)) DEFAULT-INPUT)]
    ))
