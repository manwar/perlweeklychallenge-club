(ns c230.t1
  (:require
    [clojure.edn :as edn]
    [clojure.pprint :refer [cl-format]]))

(def DEFAULT-INPUT [[1 34 5 6]])

(defn separate-digits
  [coll]
  (let [xf (mapcat (comp seq str))]
    (sequence xf coll)))

(defn -main
  "Run Task 1 with a given input COLL, defaulting to the first example from the
  task description."
  [& args]
  (let [[COLL] (or (some->> args (map edn/read-string)) DEFAULT-INPUT)]
    (cl-format true "(~{~a~^, ~})~%" (separate-digits COLL))))
