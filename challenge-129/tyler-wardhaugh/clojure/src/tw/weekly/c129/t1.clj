(ns tw.weekly.c129.t1
  (:require [clojure.edn :as edn]))

;;;
; Task description for TASK #1 › Root Distance
;;;
(def DEFAULT-INPUT [])

(defn -main
  "Run Task 1 with a given input T, defaulting to the first example from the
  task description."
  [& args]
  (let [[T] (or (some->> args (map edn/read-string)) DEFAULT-INPUT)]
    ))
