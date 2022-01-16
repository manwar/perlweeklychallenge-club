(ns c147.t1
  (:require [com.hypirion.primes :as p]))

(def TARGET 20)

(defn digits->n
  [digits]
  (parse-long (apply str digits)))

(defn left-truncatable-prime?
  [n]
  (let [digits (-> n str seq)]
    (when (not-any? #(= \0 %) digits)
      (->> (iterate rest digits)
           (drop 1)
           (take-while seq)
           (map digits->n)
           (every? p/prime?)))))

(defn left-truncatable-primes
  [n]
  (->> (p/primes)
       (filter left-truncatable-prime?)
       (take n)))


(defn -main
  [& _]
  (println (left-truncatable-primes TARGET)))
