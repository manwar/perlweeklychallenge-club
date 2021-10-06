(ns tw.weekly.c133.t2
  (:require [clojure.edn :as edn]))

;;;
; Task description for TASK #2, Smith Numbers
;;;
(def DEFAULT-INPUT [10])

; based on source: https://rosettacode.org/wiki/Prime_decomposition#Clojure
(defn prime-factors
  "Return a list of factors of n."
  ([n]
   (prime-factors n 2 (list)))
  ([n k acc]
   (cond
     (= 1 n) acc
     (zero? (rem n k)) (recur (quot n k) k (cons k acc))
     :else (recur n (inc k) acc))))

(defn sum-digits
  "Sum the individual digits of n."
  [n]
  (transduce (map #(Character/getNumericValue %)) + (str n)))

(defn smith?
  "Returns true if n is a Smith Number."
  [n]
  (let [pfs (prime-factors n)]
    (and (< 1 (count pfs))
         (= (sum-digits n) (transduce (map sum-digits) + pfs)))))

(def smiths (->> (iterate inc 1) (filter smith?)))

(defn -main
  "Run Task 2 with a given input N, defaulting to the first
  example from the task description."
  [& args]
  (let [[N] (or (some->> args (map edn/read-string)) DEFAULT-INPUT)]
    (run! println (take N smiths))))
