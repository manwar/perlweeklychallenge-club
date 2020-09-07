(ns tw.weekly.ch-1
  (:require [clojure.edn :as edn])
  (:require [clojure.math.combinatorics :as combo]))

;;; Task description (as of UPDATE: 2020-09-07 09:00:00)
; You are given a positive integer $N.
;
; Write a script to find out all possible combination of Fibonacci Numbers required to get $N on addition.
;
; You are NOT allowed to repeat a number. Print 0 if none found.
;;;

; source: [Clojure High Performance Fibonacci – Deque](https://deque.blog/2017/06/01/clojure-high-performance-fibonacci/)]
(defn fibo-lazy-seq
  "Generate the nth Fibonacci Number, starting from 0, 1, 1, ..."
  []
  (letfn [(fibs [a b] (cons a (lazy-seq (fibs b (+ a b)))))]
    (fibs 0N 1N)))

(defn fibo-sum
  "Find all combinations of Fibonacci Numbers that sum to n, returning nil if none are found."
  [n]
  (let [fibs (drop 2 (take n (fibo-lazy-seq)))
        results (->> fibs
                     combo/subsets
                     (drop 1)       ; remove the empty subset, which is always first
                     (filter #(= n (reduce + 0N %))))]
    (seq results)))

(defn -main
  "Run Task 1 with a number N, defaulting to the number given in the task example, 6."
  [& args]
  (let [N (or (some-> args first edn/read-string) 6)
        failure-result 0]
    (if-let [results (fibo-sum N)]
      (do
        (printf "Found Fibonacci numbers that sum to %d:\n" N)
        (dorun (map #(println (apply str (interpose " + " %))) results)))
      (printf "No Fibonacci numbers sum to %d:\n%d\n" N failure-result))))
