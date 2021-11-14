(ns tw.weekly.c134.t1
  (:require [clojure.edn :as edn]
            [clojure.pprint :refer [cl-format]]
            [clojure.math.combinatorics :as combo]))

;;;
; Task description for TASK #1 › Pandigital Numbers
;;;
(def DEFAULT-INPUT [5])
(def FIRST-PANDIGITAL 1023456789)
(def MAX-FACTORIAL 8)

(def factorials (map #(reduce * (range % 1 -1)) (range (inc MAX-FACTORIAL))))

(let [pan (->> FIRST-PANDIGITAL str (mapv #(Character/digit % 10)))
      panlen (count pan)]
  (defn split-pandigital
    [n]
    (-> (fn [_ i]
          (when (> (nth factorials i) n)
            (reduced [(apply str (subvec pan 0 (- panlen i)))
                      (subvec pan (- panlen i))])))
        (reduce (range panlen)))))

(defn pandigitals
  [n]
  {:pre [(<= n (last factorials))]}
  (let [[head tails] (split-pandigital n)
        source (combo/permutations tails)
        xf (comp (map (partial apply str head)) (take n))]
    (sequence xf source)))

(defn -main
  "Run Task 1 with a given input N, defaulting to the first example from the
  task description."
  [& args]
  (let [[N] (or (some->> args (map edn/read-string)) DEFAULT-INPUT)]
    (cl-format true "~{~a~%~}" (pandigitals N))))
