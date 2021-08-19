(ns tw.weekly.c126.t1
  (:require [clojure.edn :as edn]))

;;;
; Task description for TASK #1 › Count Numbers
;;;
(def DEFAULT-INPUT [])

(defn -main
  "Run Task 1 with a given input N, defaulting to the first example from the
  task description."
  [& args]
  (let [[N] (or (some->> args (map edn/read-string)) DEFAULT-INPUT)]
    ))
