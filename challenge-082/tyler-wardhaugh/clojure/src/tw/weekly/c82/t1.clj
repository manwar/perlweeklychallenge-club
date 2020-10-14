(ns tw.weekly.c82.t1
  (:require [clojure.edn :as edn]))

;;; Task description for TASK #1 › Common Factors
; Submitted by: Niels van Dijke
; You are given 2 positive numbers $M and $N.
;
; Write a script to list all common factors of the given numbers.
;;;

(defn common-factors
  "Determine the common factors for m and n."
  [m n]
  (let [[m n] (sort [m n])
        source (concat (range 1 (inc (quot n 2))) [n])
        xf (filter (fn [x] (= 0 (rem n x) (rem m x))))]
    (into (sorted-set) xf source)))

(defn -main
  "Run Task 1 with two strings A and B, defaulting to the first example given in the task description."
  [& args]
  (let [[M N] (or (some->> args (take 2) (map edn/read-string)) [12 18])
        factors (common-factors M N)]
    (println (seq factors))))
