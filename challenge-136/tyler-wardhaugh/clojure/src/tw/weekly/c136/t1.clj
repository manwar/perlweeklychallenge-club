(ns tw.weekly.c136.t1
  (:require [clojure.edn :as edn]))

;;;
; Task description for TASK #1 › Two Friendly
;;;
(def DEFAULT-INPUT [8 24])

(defn- power-of-2?
  "Assuming n is a positive BigInteger, is it a power of 2?"
  [n]
  (= (.getLowestSetBit n) (dec (.bitLength n))))

(defn two-friendly?
  "Determine if two positive integers m and n are two friendly, that is:
  gcd(m, n) = 2^p where p > 0."
  [m n]
  (when-let [gcd (.gcd (biginteger m) (biginteger n))]
    (and (< 1 gcd) (power-of-2? gcd))))

(defn -main
  "Run Task 1 with a given input M and N, defaulting to the first example from
  the task description."
  [& args]
  (let [[M N] (or (some->> args (map edn/read-string)) DEFAULT-INPUT)]
    (println (if (two-friendly? M N) 1 0))))
