(ns tw.weekly.c79.t1
  (:require [clojure.edn :as edn]))

;;; Task description for TASK #1 › Count Set Bits
;You are given a positive number $N.
;
;Write a script to count the total numbrer of set bits of the binary representations of all numbers from 1 to $N and return $total_count_set_bit % 1000000007.
;;;;

(defn count-bits-to-n
  "Count the '1' bits in the binary representation of all the integers [1..n]"
  [n]
  (let [xf (map #(Integer/bitCount %))
        source (range 1 (inc n))]
    (transduce xf + source)))

(def big-num "The large number given in the task description to modulo against"
  1000000007N)

(defn run
  "Count the 1s and modulo"
  [n]
  (mod (count-bits-to-n n) big-num))

(defn -main
  "Run Task 1 with a number N, defaulting to the first one given in the examples"
  [& args]
  (let [N (or (-> args first edn/read-string) 4)]
    (format "%d" (biginteger (run N)))))
