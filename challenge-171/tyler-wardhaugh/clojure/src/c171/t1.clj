(ns c171.t1
  (:require [clojure.edn :as edn]))

(def DEFAULT-INPUT [20])

(defn proper-divisors
  [n]
  (->> (range 2 n) (filter #(zero? (rem n %)))))

(defn abundant?
  [n]
  (< n (inc (reduce + (proper-divisors n)))))

(def generate-odd-abundants
  (eduction (filter abundant?) (range 1 ##Inf 2)))

(defn -main
  "Run Task 1 with a given input N, defaulting to the first example from the
  task description."
  [& args]
  (let [[N] (or (some->> args (map edn/read-string)) DEFAULT-INPUT)]
    (println (take N generate-odd-abundants))))
