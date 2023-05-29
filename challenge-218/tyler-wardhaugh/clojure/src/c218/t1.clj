(ns c218.t1
  (:require
    [clojure.edn :as edn]))

(def DEFAULT-INPUT [[3 1 2]])

(defn max-product
  [coll]
  (let [sorted (->> coll sort (into []))
        len (count sorted)
        three-largest (subvec sorted (- len 3))
        two-smallest-and-largest (concat (subvec sorted 0 2) [(peek sorted)])]
    (tap> [sorted three-largest two-smallest-and-largest])
    (->> [three-largest two-smallest-and-largest]
         (map #(reduce * 1 %))
         (apply max))))

(defn -main
  "Run Task 1 with a given input COLL, defaulting to the first example from the
  task description."
  [& args]
  (let [[coll] (or (some->> args (map edn/read-string)) DEFAULT-INPUT)]
    (println (max-product coll))))
