(ns tw.weekly.c80.t2
  (:require [clojure.edn :as edn]))

;;; Task description for TASK #2 › Count Candies
; Submitted by: Mohammad S Anwar
; You are given rankings of @N candidates.
;
; Write a script to find out the total candies needed for all candidates. You are asked to follow the rules below:
;
; a) You must given at least one candy to each candidate.
; b) Candidate with higher ranking get more candies than their mmediate neighbors on either side.
;;;

(defn count-candies
  "Determine the number of candies needed according to the rules in the task description."
  [coll]
  (let [xf (comp (map (juxt (fn [[a b _]] (if (> b a) 1 0))
                            (fn [[_ b c]] (if (> b c) 1 0))))
                 (map (partial apply + 1)))
        source (partition 3 1 (repeat ##Inf) (concat [##Inf] coll))]
    (transduce xf + source)))

(defn -main
  "Run Task 2 with a list of integers N, defaulting to the first one given in the examples."
  [& args]
  (let [N (or (some->> args (map edn/read-string)) [1 2 2])]
    (println (count-candies N))))
