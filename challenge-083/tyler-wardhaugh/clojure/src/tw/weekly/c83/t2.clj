(ns tw.weekly.c83.t2
  (:require [clojure.edn :as edn])
  (:require [clojure.math.combinatorics :as combo])
  (:require [net.cgrand.xforms :as x]))

;;; Task description for
; TASK #2 › Flip Array
; Submitted by: Mohammad S Anwar
; You are given an array @A of positive numbers.
;
; Write a script to flip the sign of some members of the given array so that
; the sum of the all members is minimum non-negative.
;
; Given an array of positive elements, you have to flip the sign of some of its
; elements such that the resultant sum of the elements of array should be
; minimum non-negative(as close to zero as possible). Return the minimum no. of
; elements whose sign needs to be flipped such that the resultant sum is
; minimum non-negative.
;
; Example 1:
; Input: @A = (3, 10, 8)
; Output: 1

; Explanation:
; Flipping the sign of just one element 10 gives the result 1 i.e. (3) + (-10) + (8) = 1
;
;
; Example 2:
; Input: @A = (12, 2, 10)
; Output: 1
;
; Explanation:
; Flipping the sign of just one element 12 gives the result 0 i.e. (-12) + (2) + (10) = 0
;
;;;

(defn flip-array
  "Determine the minimum number of 'flips' needed to produce the smallest non-negative sum."
  [coll]
  (let [source (->> coll (map (juxt - +)) (apply combo/cartesian-product))
        xf (comp
             (x/by-key (partial reduce +) (x/into []))
             (remove (comp neg? first))
             x/min
             x/vals
             cat
             (map (comp count (partial filter neg?))))]
    (reduce min ##Inf (eduction xf source))))

(defn -main
  "Run Task 2 with an array of integers, defaulting to the example given in the task description."
  [& args]
  (let [A (or (some->> args (map edn/read-string)) [3 10 8])
        minimum (flip-array A)]
    (println minimum)))
