(ns c223.t1
  (:require
    [clojure.edn :as edn]
    [com.hypirion.primes :as p]))

(def DEFAULT-INPUT [10])

(defn count-primes
  [n]
  (count (p/take-below n)))

(defn -main
  "Run Task 1 with a given input N, defaulting to the first example from the
  task description."
  [& args]
  (let [[N] (or (some->> args (map edn/read-string)) DEFAULT-INPUT)]
    (println (count-primes N))))
