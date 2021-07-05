(ns tw.weekly.c119.t1
  (:require [clojure.edn :as edn]))

;;;
; Task description for TASK #1 › Swap Nibbles
;;;
(def DEFAULT-INPUT [101])

(defn swap-nibbles
  "Swap the two nibbles of the binary representation of n."
  [n]
  (bit-or
    (bit-and n (bit-not 2r11111111))
    (unsigned-bit-shift-right (bit-and n 2r11110000) 4)
    (bit-shift-left (bit-and n 2r00001111) 4)))

(defn -main
  "Run Task 1 with a given input N, defaulting to the first example from the
  task description."
  [& args]
  (let [[N] (or (some->> args (map edn/read-string)) DEFAULT-INPUT)]
    (println (swap-nibbles N))))
