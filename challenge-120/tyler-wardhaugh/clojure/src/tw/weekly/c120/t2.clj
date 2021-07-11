(ns tw.weekly.c120.t2
  (:require [clojure.edn :as edn]))

;;;
; Task description for TASK #2 › Clock Angle
;;;
(def DEFAULT-INPUT ["03:10"])

(defn clock-angle
  "Find the smaller angle formed by the hands of an analog clock at a given
  time."
  [n])

(defn -main
  "Run Task 2 with a given input N, defaulting to the first example from the
  task description."
  [& args]
  (let [[T] (or (some->> args (map edn/read-string)) DEFAULT-INPUT)]
    (println (clock-angle T))))
