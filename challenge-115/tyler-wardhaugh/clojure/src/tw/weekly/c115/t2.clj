(ns tw.weekly.c115.t2
  (:require [clojure.edn :as edn]))

;;;
; Task description for TASK #2 › Largest Multiple
;;;
(def DEFAULT-INPUT [1 0 2 6])

(defn largest-multiple
  ""
  [coll])

(defn -main
  "Run Task 2 with a given input N, defaulting to the first example from the
  task description."
  [& args]
  (let [N (or (some->> args (map edn/read-string)) DEFAULT-INPUT)]
    (println (largest-multiple N))))
