(ns c160.t2
  (:require [clojure.edn :as edn]))

(def DEFAULT-INPUT [[1 3 5 7 9]])

(defn splits
  [coll]
  (let [v (vec coll)
        len (count v)]
    (->> (range len)
         (map (fn [i] [i (subvec v 0 i) (subvec v (inc i) len)])))))

(defn equilibrium-index
  [coll]
  (let [source (splits coll)
        xf (keep (fn [[i a b]] (when (= (reduce + a) (reduce + b)) i)))]
    (transduce xf (completing #(reduced %2)) -1 source)))

(defn -main
  "Run Task 2 with a given input N, defaulting to the first example from the
  task description."
  [& args]
  (let [[N] (or (some->> args (map edn/read-string)) DEFAULT-INPUT)]
    (println (equilibrium-index N))))
