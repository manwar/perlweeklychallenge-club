(ns tw.weekly.c93.t2
  (:require [clojure.edn :as edn]
            [clojure.pprint :refer [cl-format]]))

;;;
; Task description for TASK #2 › Insert Interval
;;;

(def DEFAULT-INPUT {:N [2 6] :S [[1 4], [8 10]]})

(defn -main
  "Run Task 2 with the given positive integers, defaulting to the example
  given in the explanation page linked from the task description."
  [& args]
  (let [[] (or (some-> args first edn/read-string vec) (:N DEFAULT-INPUT))]
    ))
