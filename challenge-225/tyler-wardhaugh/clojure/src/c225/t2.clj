(ns c225.t2
  (:require
    [clojure.edn :as edn]
    [clojure.pprint :refer [cl-format]]))

(def DEFAULT-INPUT [[10 4 8 3]])

(defn left-right-sum-diff
  [coll]
  (let [left (->> coll (reductions + 0) butlast)
        right (->> coll reverse (reductions + 0) butlast reverse)]
    (map (comp abs -) left right)))

(defn -main
  "Run Task 2 with a given input COLL, defaulting to the first example from the
  task description."
  [& args]
  (let [[COLL] (or (some->> args (map edn/read-string)) DEFAULT-INPUT)]
    (cl-format true "(~{~a~^, ~})~%" (left-right-sum-diff COLL))))
