(ns tw.weekly.c116.t2
  (:require [clojure.edn :as edn]
            [clojure.math.numeric-tower :as math]))

;;;
; Task description for TASK #2 › Sum of Squares
;;;
(def DEFAULT-INPUT [34])

(defn sum-of-squares
  "Determine whether the given number n (an integer that is >= 10)
  such that sum of squares of all digits is a perfect square."
  [n]
  (let [source (->> n str seq (map (comp #(Integer/parseInt %) str)))
        xf (map #(math/expt % 2))
        sum (transduce xf + source)
        sqrt (math/sqrt sum)]
    (= sqrt (math/floor sqrt))))

(defn -main
  "Run Task 2 with a given input N, defaulting to the first example from the
  task description."
  [& args]
  (let [[N] (or (some->> args (map edn/read-string)) DEFAULT-INPUT)]
    (println (if (sum-of-squares N) 1 0))))
