(ns tw.weekly.c117.t2
  (:require [clojure.edn :as edn]))

;;;
; Task description for TASK #2 › Find Possible Paths
;;;
(def DEFAULT-INPUT [2])

(defn find-possible-paths
  ""
  [n])

(defn -main
  "Run Task 2 with a given input N, defaulting to the first example from the
  task description."
  [& args]
  (let [[N] (or (some->> args (map edn/read-string)) DEFAULT-INPUT)]
    (println (find-possible-paths N))))
