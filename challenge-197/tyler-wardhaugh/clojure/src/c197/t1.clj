(ns c197.t1
  (:require
    [clojure.edn :as edn]
    [clojure.pprint :refer [cl-format]]))

(def DEFAULT-INPUT ['(1, 0, 3, 0, 0, 5)])

(defn move-zero
  [coll]
  (let [{z true, nz false} (group-by zero? coll)]
    (into nz z)))

(defn -main
  "Run Task 1 with a given input COLL, defaulting to the first example from
  the task description."
  [& args]
  (let [[coll] (or (some->> args (map edn/read-string)) DEFAULT-INPUT)]
    (cl-format true "(~{~a~^, ~})~%" (move-zero coll))))
