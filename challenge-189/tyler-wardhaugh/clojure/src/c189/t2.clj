(ns c189.t2
  (:require [clojure.edn :as edn]))

(def DEFAULT-INPUT [[1 3 3 2]])

(defn degree
  [coll]
  (->> coll frequencies vals (apply max)))

(defn array-degree
  [coll]
  (let [coll-degree (degree coll)]
    (->> (range coll-degree (count coll))
         (mapcat #(partition % 1 coll))
         (filter #(= coll-degree (degree %)))
         first)))

(defn -main
  "Run Task 2 with a given input N, defaulting to the first example from
  the task description."
  [& args]
  (let [[N] (or (some->> args (map edn/read-string)) DEFAULT-INPUT)]
    (println (array-degree N))))
