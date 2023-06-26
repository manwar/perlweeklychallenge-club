(ns c222.t2
  (:require
    [clojure.edn :as edn]))

(def DEFAULT-INPUT [[2 7 4 1 8 1]])

(defn last-member
  [coll]
  (loop [coll (shuffle coll)]
    (let [len (count coll)]
      (if (< 1 len)
        (let [[a b & rest] coll]
          (recur (if (= a b) rest (conj rest (- a b)))))
        len))))

(defn -main
  "Run Task 2 with a given input COLL, defaulting to the first example from the
  task description."
  [& args]
  (let [[coll] (or (some->> args (map edn/read-string)) DEFAULT-INPUT)]
    (println (last-member coll))))
