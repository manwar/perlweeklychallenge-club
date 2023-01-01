(ns c197.t2
  (:require
    [clojure.edn :as edn]
    [clojure.pprint :refer [cl-format]]))

(def DEFAULT-INPUT ['(1,5,1,1,6,4)])

(defn wiggle-sort
  "Tweaked wiggle sort that goes by n1 <= n2 >= n3 ..."
  [coll]
  (let [mid (quot (inc (count coll)) 2)
        [high low] (split-at mid (sort (comp - compare) coll))]
    (interleave low high)))

(defn -main
  "Run Task 2 with a given input COLL, defaulting to the first example from
  the task description."
  [& args]
  (let [[coll] (or (some->> args (map edn/read-string)) DEFAULT-INPUT)]
    (cl-format true "(~{~a~^, ~})~%" (wiggle-sort coll))))
