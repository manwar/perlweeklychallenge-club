(ns c191.t2
  (:require [clojure.edn :as edn]))

(def DEFAULT-INPUT [2])

; adapted from: https://rosettacode.org/wiki/Determinant_and_permanent#Common_Lisp
(defn permanent'
  [mf rows skip-cols]
  (let [source (range (count (first rows)))
        f (fn [result col]
            (if (skip-cols col)
              result
              (if (nil? (next rows))
                (reduced (nth (first rows) col))
                (+ result (* (nth (first rows) col)
                             (mf mf (next rows) (conj skip-cols col)))))))]
    (reduce f 0 source)))

(let [mf (memoize permanent')]
  (def permanent #(mf mf % #{})))

(defn generate-cute-matrix
  [n]
  (->> (for [i (range 1 (inc n))
             j (range 1 (inc n))]
         (if (or (zero? (mod i j)) (zero? (mod j i))) 1 0))
       (partition n)))

; adapted from: https://oeis.org/A320843 ("PROG" entry)
(defn cute-list
  [n]
  (if (zero? n)
    1
    (-> n generate-cute-matrix permanent)))

(defn -main
  "Run Task 2 with a given input N, defaulting to the first example from
  the task description."
  [& args]
  (let [[N] (or (some->> args (map edn/read-string)) DEFAULT-INPUT)]
    (println (cute-list N))))
