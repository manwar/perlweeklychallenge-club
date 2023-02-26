(ns c205.t1
  (:require
    [clojure.edn :as edn]))

(def DEFAULT-INPUT [[5 4 3]])

(defn third-highest
  [coll]
  (let [sorted (->> coll (into (sorted-set-by (comp - compare))) seq)]
    (nth sorted 2 (first sorted))))

(defn -main
  "Run Task 1 with a given input COLL, defaulting to the first example from
  the task description."
  [& args]
  (let [[coll] (or (some->> args (map edn/read-string)) DEFAULT-INPUT)]
    (println (third-highest coll))))
