(ns tw.weekly.c90.t2
  (:require [clojure.edn :as edn]))

;;;
; Task description for TASK #2 › Ethiopian Multiplication
;;;

(defn ethiopian-multiply
  "Compute the product of two positive integers using Ethiopian Multiplication."
  [a b]
  (let [source (map vector (iterate #(quot % 2) a) (iterate #(* 2 %) b))
        xf (comp
             (take-while (fn [[a _]] (pos? a)))
             (keep (fn [[a b]] (when (odd? a) b))))]
    (transduce xf + source)))

(defn -main
  "Run Task 2 with the given positive integers, defaulting to the example
  given in the explanation page linked from the task description."
  [& args]
  (let [[A B] (or (some->> args (take 2) (map edn/read-string)) [12 14])]
    (println (ethiopian-multiply A B))))
