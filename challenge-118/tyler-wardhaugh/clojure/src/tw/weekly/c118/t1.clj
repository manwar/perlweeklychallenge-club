(ns tw.weekly.c118.t1
  (:require [clojure.edn :as edn]
            [clojure.string :as str]))

;;;
; Task description for TASK #1 › Binary Palindrom
;;;
(def DEFAULT-INPUT [5])

(defn bin-parse
  "Parse a string as a binary representation of an integer."
  [s]
  (Integer/parseInt s 2))

(defn binary-palindrome
  "Determine if the binary representation of an integer is a palindrome."
  [n]
  (let [rev (-> n Integer/toBinaryString str/reverse bin-parse)]
    (zero? (bit-xor n rev))))

(defn -main
  "Run Task 1 with a given input N, defaulting to the first example from the
  task description."
  [& args]
  (let [[N] (or (some->> args (map edn/read-string)) DEFAULT-INPUT)]
    (println (if (binary-palindrome N) 1 0))))
