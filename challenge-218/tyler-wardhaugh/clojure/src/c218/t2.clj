(ns c218.t2
  (:require
    [clojure.edn :as edn]
    [clojure.core.matrix :as mat]
    [clojure.string :as str]))

(def DEFAULT-INPUT
  [[[0 0 1 1]
    [1 0 1 0]
    [1 1 0 0]]])

(defn score
  [m]
  (-> (map #(-> (map int %) str/join (Long/parseLong 2)))
      (transduce + 0 (mat/rows m))))

(defn max-matrix-score
  [coll]
  (let [m (mat/mutable coll)
        n-dim (mat/dimension-count m 0)]

    ; maximize rows
    (loop [[r & rs] (mat/rows m)
           i 0]
      (when r
        (when (zero? (mat/mget r 0))
          (mat/set-row! m i (mat/eif r 0 1)))
        (recur rs (inc i))))

    ; maximize columns
    (loop [[c & cs] (mat/columns m)
           i 0]
      (when c
        (when (and (pos? i)
                   (<= (mat/non-zero-count c) (quot n-dim 2)))
          (mat/set-column! m i (mat/eif c 0 1)))
        (recur cs (inc i))))

    (score m)))

(defn -main
  "Run Task 2 with a given input COLL, defaulting to the first example from the
  task description."
  [& args]
  (let [[coll] (or (some->> args (map edn/read-string)) DEFAULT-INPUT)]
    (println (max-matrix-score coll))))
