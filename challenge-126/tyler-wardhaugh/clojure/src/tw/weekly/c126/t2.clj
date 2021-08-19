(ns tw.weekly.c126.t2
  (:require [clojure.edn :as edn]
            [clojure.string :as str]
            [clojure.math.numeric-tower :refer [abs]]))

;;;
; Task description for TASK #2 › Clock Angle
;;;
(def DEFAULT-INPUT [])

(defn -main
  "Run Task 2 with a given input N, defaulting to the first example from the
  task description."
  [& args]
  (let [[T] (or args DEFAULT-INPUT)]
    ))
