(ns c198.t1
  (:require
    [clojure.edn :as edn]))

(def DEFAULT-INPUT [[2 5 8 1]])

(defn max-gap
  [coll]
  (if (< (count coll) 2)
    0
    (let [pairs (->> coll sort (partition 2 1))
          grouped (group-by (fn [[a b]] (- b a)) pairs)
          max-key (apply max (keys grouped))]
      (-> grouped (get max-key []) count))))

(defn -main
  "Run Task 1 with a given input COLL, defaulting to the first example from
  the task description."
  [& args]
  (let [[coll] (or (some->> args (map edn/read-string)) DEFAULT-INPUT)]
    (println (max-gap coll))))
