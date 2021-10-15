(ns tw.weekly.c134.t2
  (:require [clojure.edn :as edn]))

;;;
; Task description for TASK #2 ›
;;;
(def DEFAULT-INPUT [])

(defn -main
  "Run Task 1 with a given input N, defaulting to the first example from the
  task description."
  [& args]
  (let [[N] (or (some->> args (map edn/read-string)) DEFAULT-INPUT)]
    ))
