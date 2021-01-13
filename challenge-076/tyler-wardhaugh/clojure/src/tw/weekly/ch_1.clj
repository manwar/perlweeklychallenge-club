(ns tw.weekly.ch-1
  (:require [clojure.edn :as edn])
  (:require [clojure.math.combinatorics :as combo])
  (:require [com.hypirion.primes :as p]))

; My initial attempt, which I've preserved here.
(defn find-min-primes-to-sum-brute-force
  "Find the minimum number of prime numbers required, whose summation gives you the argument provided, by brute force."
  [n]
  (if (p/prime? n)
    [n]
    (->> n
      p/take-below
      ((juxt #(combo/selections % 2) #(combo/selections % 3)))
      (apply concat)
      (filter #(= n (reduce + %)))
      (sort-by count)
      first)))

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
    :else (conj (find-min-primes-to-sum (- n 3)) 3)))

(defn -main
  "Run Task 1 with a number N, defaulting to the number given in the task example, 9."
  [& args]
  (let [N (or (some-> args first edn/read-string) 9)
        solution (find-min-primes-to-sum N)]
    (printf "%d prime number(s) are the minimum number required to sum to %d:\n" (count solution) N)
    (printf "%d = %s" N (apply str (interpose " + " solution)))))
