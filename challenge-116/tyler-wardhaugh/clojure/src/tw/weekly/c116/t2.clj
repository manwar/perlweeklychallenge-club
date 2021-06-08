(ns tw.weekly.c116.t2
  (:require [clojure.edn :as edn]))

;;;
; Task description for TASK #2 › Sum of Squares
;;;
(def DEFAULT-INPUT [34])

(defn -main
  "Run Task 2 with a given input N, defaulting to the first example from the
  task description."
  [& args]
  (let [[N] (or (some->> args (map edn/read-string)) DEFAULT-INPUT)]
    ))
