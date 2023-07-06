(ns c223.t2
  (:require
    [clojure.edn :as edn]
    [net.cgrand.xforms :as x]))

(def DEFAULT-INPUT [[3 1 5 8]])

(defn prod-windows
  [coll]
  (let [source (into [1] coll)
        xf (comp (x/partition 3 1 (repeat 1) (x/reduce * 1))
                 (map-indexed vector))]
    (eduction xf source)))

(defn remove-index
  [i coll]
  (into (subvec coll 0 i) (subvec coll (inc i))))

(defn box-coins'
  [f coll]
  (case (count coll)
    0 0
    1 (first coll)
    (x/some (comp (map (fn [[i prod]] (+ prod (f f (remove-index i coll)))))
                  x/max)
            (prod-windows coll))))

(let [f (memoize box-coins')]
  (defn box-coins [coll]
    (f f (vec coll))))

(defn -main
  "Run Task 2 with a given input COLL, defaulting to the first example from the
  task description."
  [& args]
  (let [[coll] (or (some->> args (map edn/read-string)) DEFAULT-INPUT)]
    (println (box-coins coll))))
