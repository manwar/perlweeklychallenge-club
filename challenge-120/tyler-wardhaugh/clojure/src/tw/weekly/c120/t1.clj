(ns tw.weekly.c120.t1
  (:require [clojure.edn :as edn]))

;;;
; Task description for TASK #1 › Swap Odd/Even bits
;;;
(def DEFAULT-INPUT [101])

(defn swap-bits
  "Swap the odd positioned bit with even positioned bit and print the
  decimal equivalent of the new binary representation."
  [n])

(defn -main
  "Run Task 1 with a given input N, defaulting to the first example from the
  task description."
  [& args]
  (let [[N] (or (some->> args (map edn/read-string)) DEFAULT-INPUT)]
    (println (swap-bits N))))
