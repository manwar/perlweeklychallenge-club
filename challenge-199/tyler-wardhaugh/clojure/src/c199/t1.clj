(ns c199.t1
  (:require
    [clojure.edn :as edn]))

(def DEFAULT-INPUT [[1 2 3 1 1 3]])

(defn good-pairs
  [coll]
  (let [source (->> coll frequencies vals)
        xf (keep (fn [n] (when (< 1 n) (quot (* n (dec n)) 2))))]
    (transduce xf + 0 source)))

(defn -main
  "Run Task 1 with a given input COLL, defaulting to the first example from
  the task description."
  [& args]
  (let [[coll] (or (some->> args (map edn/read-string)) DEFAULT-INPUT)]
    (println (good-pairs coll))))
