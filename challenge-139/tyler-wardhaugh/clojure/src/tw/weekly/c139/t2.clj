(ns tw.weekly.c139.t2
  (:require [com.hypirion.primes :as p]))

;;;
; Task description for TASK #2 › Long Primes
;;;
(def BASE 10)

(defn cyclic?
  [n]
  (let [s (str n)
        len (count s)
        ndigits (set s)
        ndigits' (conj ndigits \0)
        f (fn [x] (let [odigits (-> x str set)]
                    (or (= ndigits odigits) (= ndigits' odigits))))]
    (every? f (map #(* n %) (range 2 len)))))

(defn long-prime?
  [n]
  (-> (biginteger BASE)
      (.pow (dec n))
      (.subtract (biginteger 1))
      (.divide (biginteger n))
      cyclic?))

(defn long-primes
  []
  (let [xf (comp (drop 2) (filter long-prime?) (take 5))]
    (sequence xf (p/primes))))

(defn -main
  "Run Task 2."
  [& _]
  (long-primes))
