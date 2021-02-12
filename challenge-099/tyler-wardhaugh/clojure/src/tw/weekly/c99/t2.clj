(ns tw.weekly.c99.t2
  (:require [clojure.edn :as edn]
            [clojure.core.matrix :as m]))

;;;
; Task description for TASK #2 › Unique Subsequence
;;;

(def DEFAULT-INPUT ["littleit" "lit"])

(defn- uniq-subseq-dp
  "Use a dynamic programming algorithm to solve unique subsequences.
  Source: https://www.geeksforgeeks.org/count-distinct-occurrences-as-a-subsequence/"
  [s t m n]
  (let [m+1 (inc m)
        n+1 (inc n)
        dp (m/mutable (m/zero-matrix :ndarray m+1 n+1))]
    (m/set-column! dp 0 (repeat m+1 0))
    (m/set-row! dp 0 (repeat n+1 1))
    (dorun (for [i (range 1 m+1)
                 j (range 1 n+1)]
             (let [schar (nth s (dec j))
                   tchar (nth t (dec i))]
               (if (not= schar tchar)
                 (m/mset! dp i j (m/mget dp i (dec j)))
                 (m/mset! dp i j (+ (m/mget dp i (dec j))
                                     (m/mget dp (dec i) (dec j))))))))
    (m/mget dp m n)))

(defn unique-subsequences
  "Count the unique subsequences of string t in string s"
  [s t]
  (let [m (count t)
        n (count s)]
    (if (> m n)
      0
      (uniq-subseq-dp s t m n))))

(defn -main
  "Run Task 2 using a sorted sequence of integers NS and a target N,
  defaulting to the example given in the task description."
  [& args]
  (let [[S T] (or (some->> args (take 2) (map edn/read-string)) DEFAULT-INPUT)]
    (println (unique-subsequences S T))))
