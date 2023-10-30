(ns c233.t1
  (:require
    [clojure.edn :as edn]
    [net.cgrand.xforms :as x]))

(def DEFAULT-INPUT ['("aba", "aabb", "abcd", "bac", "aabc")])

(defn similar-words
  [coll]
  (->> coll
       (transduce (comp
                    (x/by-key set x/count)
                    (map (fn [[_ x]] (quot (* x (dec x)) 2))))
                  +
                  0)))

(defn -main
  "Run Task 1 with a given input COLL, defaulting to the first example from the
  task description."
  [& args]
  (let [[COLL] (or (some->> args (map edn/read-string)) DEFAULT-INPUT)]
    (println (similar-words COLL))))
