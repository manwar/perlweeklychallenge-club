(ns tw.weekly.c119.t1
  (:require [clojure.edn :as edn]))

;;;
; Task description for TASK #1 › Swap Nibbles
;;;
(def DEFAULT-INPUT [101])

(defn swap-nibbles
  ""
  [n])

(defn -main
  "Run Task 1 with a given input N, defaulting to the first example from the
  task description."
  [& args]
  (let [[N] (or (some->> args (map edn/read-string)) DEFAULT-INPUT)]
    (println (swap-nibbles N))))
