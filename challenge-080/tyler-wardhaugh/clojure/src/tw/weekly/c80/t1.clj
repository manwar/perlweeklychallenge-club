(ns tw.weekly.c80.t1
  (:require [clojure.edn :as edn])
  (:require [clojure.set :as set]))

;;; Task description for TASK #1 › Smallest Positive Number Bits
;Submitted by: Mohammad S Anwar
;You are given unsorted list of integers @N.
;
;Write a script to find out the smallest positive number missing.
;;;;

(defn smallest-missing-by-set
  "Determine the smallest positive integer missing in a sequence (by set difference)."
  [coll]
  (if-let [missing (->> coll
                        ((juxt #(set (range 1 (inc (apply max %)))) set))
                        (apply set/difference)
                        seq)]
      (apply min missing)
      1))

(defn smallest-missing-by-sorting
  "Determine the smallest positive integer missing in a sequence (by sorting)."
  [coll]
  (if-let [sorted (->> coll (filter pos-int?) sort seq)]
    (->> (map vector (iterate inc 1) sorted)
         (filter (partial apply not=))
         (take 1)
         ffirst)
    1))

(def smallest-missing smallest-missing-by-sorting)

(defn -main
  "Run Task 1 with a list of integers N, defaulting to the first one given in the examples."
  [& args]
  (let [N (or (some->> args (map edn/read-string)) [5 2 -2 0]) ]
    (if-let [smallest (smallest-missing N)]
      (println smallest)
      (println "No positive integer is missing in the given sequence."))))
