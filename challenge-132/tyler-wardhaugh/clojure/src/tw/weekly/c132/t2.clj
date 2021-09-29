(ns tw.weekly.c132.t2
  (:require [clojure.edn :as :edn))

;;;
; Task description for TASK #2, Hash Join
;;;
(def DEFAULT-INPUT [])

(defn -main
  "Run Task 1 with a given input D and S, defaulting to the first example from
  the task description."
  [& args]
  (let [[H1 H2] (or (some->> args (map edn/read-string)) DEFAULT-INPUT)]
    ))
