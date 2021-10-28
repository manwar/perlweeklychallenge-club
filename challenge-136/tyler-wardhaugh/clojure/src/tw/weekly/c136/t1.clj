(ns tw.weekly.c136.t1
  (:require [clojure.edn :as edn]))

;;;
; Task description for TASK #1 › Two Friendly
;;;
(def DEFAULT-INPUT [8 24])

(defn -main
  "Run Task 1 with a given input M and N, defaulting to the first example from
  the task description."
  [& args]
  (let [[M N] (or (some->> args (map edn/read-string)) DEFAULT-INPUT)]
    ))
