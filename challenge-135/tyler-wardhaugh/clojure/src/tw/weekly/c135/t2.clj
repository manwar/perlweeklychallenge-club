(ns tw.weekly.c135.t2
  (:require [clojure.edn :as edn]))

;;;
; Task description for TASK #2 › Validate SEDOL
;;;
(def DEFAULT-INPUT [2936921])

(defn -main
  "Run Task 1 with a given input M and N, defaulting to the first example from
  the task description."
  [& args]
  (let [[SEDOL] (or (some->> args (map edn/read-string)) DEFAULT-INPUT)]
    ))
