(ns c199.t2
  (:require
    [clojure.edn :as edn]))

(def DEFAULT-INPUT [7 2 3 [3 0 1 1 9 7]])

(defn good-triplets
  [x y z coll]
  (let [indexed (map-indexed vector coll)]
    (->> (for [[i ai] indexed
               [j aj] (drop 1 indexed)
               :when (and (< i j)
                          (<= (abs (- ai aj)) x))
               [k ak] (drop 2 indexed)
               :when (and (< j k)
                          (<= (abs (- aj ak)) y)
                          (<= (abs (- ai ak)) z))]
           1)
         (reduce + 0))))

(defn -main
  "Run Task 2 with a given input X, Y, Z, and COLL, defaulting to the first
  example from the task description."
  [& args]
  (let [[x y z coll] (or (some->> args (map edn/read-string)) DEFAULT-INPUT)]
    (println (good-triplets x y z coll))))
