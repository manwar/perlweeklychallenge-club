(ns c229.t2
  (:require
    [clojure.edn :as edn]
    [clojure.pprint :refer [cl-format]]
    [clojure.set :as set]))

(def DEFAULT-INPUT [[1 1 2 4] [2 4] [4]])

(defn two-of-three
  [a b c]
  (let [sa (set a)
        sb (set b)
        sc (set c)]
    (->> (set/union
           (set/intersection sa sb)
           (set/intersection sa sc)
           (set/intersection sb sc))
         sort)))

(defn -main
  "Run Task 2 with a given input COLL, defaulting to the first example from the
  task description."
  [& args]
  (let [[A B C] (or (some->> args (map edn/read-string)) DEFAULT-INPUT)]
    (cl-format true "(~{~a~^, ~})~%" (two-of-three A B C))))
