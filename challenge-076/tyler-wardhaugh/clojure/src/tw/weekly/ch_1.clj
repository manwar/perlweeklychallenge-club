(ns tw.weekly.ch-1
  (:require [clojure.edn :as edn])
  (:require [clojure.math.combinatorics :as combo])
  (:require [com.hypirion.primes :as p]))

; My initial attempt, which I've preserved here.
(defn find-min-primes-to-sum-brute-force
  "Find the minimum number of prime numbers required, whose summation gives you the argument provided, by brute force."
  [n]
  (if (p/prime? n) [n]
    (as-> n x
      (p/take-below x)
      (combo/partitions x :min 2 :max 3)
      (mapcat identity x)
      (filter #(= n (reduce + %)) x)
      (sort-by count x)
      (first x))))

; basis for algorithm:
;   https://stackoverflow.com/a/35756072
;   StackOverflow answer by user448810
(defn find-min-primes-to-sum
  "Find the minimum number of prime numbers required, whose summation gives you the argument provided."
  [n]
  (cond
    (p/prime? n) [n]
    (even? n) (let [f (juxt #(- n %) identity)] (->> (p/primes) (filter #(p/prime? (- n %))) first f))
    (and (odd? n) (p/prime? (- n 2))) [2 (- n 2)]
    :else (conj 3 (find-min-primes-to-sum (- n 3)))))

(defn -main
  "Run Task 1 with a number N, defaulting to the number given in the task example, 9."
  [& args]
    (let [N (or (some-> args first edn/read-string) 9)]
    (let [solution (find-min-primes-to-sum N)]
      (printf "%d prime number(s) are the minimum number required to sum to %d.\n" (count solution) N)
      (println solution))))
