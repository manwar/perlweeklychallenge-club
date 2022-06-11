(ns c152.t1
  (:require [clojure.edn :as edn]
            [clojure.pprint :refer [cl-format]]))

(def DEFAULT-INPUT [[[1], [5,3], [2,3,4], [7,1,0,2], [6,4,5,2,8]]])

(defn min-triangle-sum-path
  [triangle]
  (map (partial reduce min) triangle))
  
(defn -main
  "Run Task 1 using a triangle T, defaulting to the example given in the
  task description."
  [& args]
  (let [[T] (or (some->> args (map edn/read-string)) DEFAULT-INPUT)
        path (min-triangle-sum-path T)]
    (cl-format true "Minimum Sum Path = ~{~a~^ + ~} => ~a~%"
               path (reduce + path))))
