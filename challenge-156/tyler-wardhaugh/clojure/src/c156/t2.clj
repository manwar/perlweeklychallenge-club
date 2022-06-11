(ns c156.t2
  (:require [clojure.edn :as edn]
            [clojure.math.combinatorics :as combo]))

(def DEFAULT-INPUT [12])

(defn proper-divisors
  [n]
  (->> (range 2 n) (filter #(zero? (rem n %)))))

(defn weird?
  [n]
  (let [divs (proper-divisors n)]
    (and
      (> (reduce + divs) n)
      (not-any? 
        #{n} 
        (->> (combo/subsets divs) (map #(reduce + %)))))))

(defn -main
  "Run Task 2 with a given input N, defaulting to the first example from the
  task description."
  [& args]
  (let [[N] (or (some->> args (map edn/read-string)) DEFAULT-INPUT)]
    (println (if (weird? N) 1 0))))
