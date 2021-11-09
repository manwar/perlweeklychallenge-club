(ns tw.weekly.c138.t1
  (:require [clojure.edn :as edn]
            [java-time :as j]))

;;;
; Task description for TASK #1 › Workdays
;;;
(def DEFAULT-INPUT [2021])

(defn count-workdays
  [year]
  (let [start (j/local-date year 1 1)
        end (j/plus start (j/years 1))
        source (j/iterate j/adjust start :next-working-day)
        xf (take-while #(j/before? % end))]
    (count (sequence xf source))))

(defn -main
  "Run Task 2 with a given input N, defaulting to the first example from the
  task description."
  [& args]
  (let [[N] (or (some->> args (map edn/read-string)) DEFAULT-INPUT)]
    (println (count-workdays N))))
