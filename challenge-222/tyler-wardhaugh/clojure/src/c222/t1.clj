(ns c222.t1
  (:require
    [clojure.edn :as edn]))

(def DEFAULT-INPUT [[1 1 4 2 1 3]])

(defn matching-members
  [coll]
  (->> [coll (sort coll)]
       (apply map vector)
       (keep (fn [[a b]] (when (= a b) a)))
       count))

(defn -main
  "Run Task 1 with a given input COLL, defaulting to the first example from the
  task description."
  [& args]
  (let [[coll] (or (some->> args (map edn/read-string)) DEFAULT-INPUT)]
    (println (matching-members coll))))
