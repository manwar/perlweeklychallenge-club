(ns tw.weekly.c139.t1
  (:require [clojure.edn :as edn]))

;;;
; Task description for TASK #1 › JortSort
;;;
(def DEFAULT-INPUT [[1 2 3 4 5]])

(defn -main
  "Run Task 3 with a given input COLL, defaulting to the first example from the
  task description."
  [& args]
  (let [[COLL] (or (some->> args (map edn/read-string)) DEFAULT-INPUT)]
    ))
