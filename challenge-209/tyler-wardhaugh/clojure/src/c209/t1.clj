(ns c209.t1
  (:require
    [clojure.edn :as edn]))

(def DEFAULT-INPUT [[1 0 0]])

(defn ends-with-a?
  [coll]
  (and (odd? (count coll)) (zero? (last coll))))

(defn -main
  "Run Task 1 with a given input COLL, defaulting to the first example from
  the task description."
  [& args]
  (let [[coll] (or (some->> args (map edn/read-string)) DEFAULT-INPUT)]
    (println (if (ends-with-a? coll) 1 0))))
