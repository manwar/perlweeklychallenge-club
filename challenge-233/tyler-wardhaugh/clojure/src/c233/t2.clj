(ns c233.t2
  (:require
    [clojure.edn :as edn]
    [clojure.pprint :refer [cl-format]]
    [net.cgrand.xforms :as x]))

(def DEFAULT-INPUT ['(1,1,2,2,2,3)])

(defn freq-sort
  [coll]
  (->> coll
       (sequence (comp (x/by-key identity x/count)
                       (x/sort-by (juxt second (comp - first)))
                       (mapcat (fn [[x n]] (repeat n x)))))))

(defn -main
  "Run Task 2 with a given input COLL, defaulting to the first example from the
  task description."
  [& args]
  (let [[COLL] (or (some->> args (map edn/read-string)) DEFAULT-INPUT)]
    (cl-format true "~{~a~^, ~}~%" (freq-sort COLL))))
