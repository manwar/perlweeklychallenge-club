(ns tw.weekly.c129.t2
  (:require [clojure.edn :as edn]))

;;;
; Task description for TASK #2, Add Linked Lists
;;;
(def DEFAULT-INPUT [])

(defn -main
  "Run Task 1 with a given input L, defaulting to the first example from the
  task description."
  [& args]
  (let [[L] (or (some->> args (map edn/read-string)) DEFAULT-INPUT)]
    ))
