(ns c187.t2
  (:require [clojure.edn :as edn]
            [clojure.pprint :refer [cl-format]]))

(def DEFAULT-INPUT ['(1, 2, 3, 2)])

(defn magical-triplet
  [coll]
  (when-let [[a b c] (sort > coll)]
    (when (and a b c (< a (+ b c)))
      [a b c])))

(defn -main
  "Run Task 2 with a given input N, defaulting to the first example from
  the task description."
  [& args]
  (let [[N] (or (some->> args (map edn/read-string)) DEFAULT-INPUT)]
    (cl-format true "(~{~a~^, ~})~%" (magical-triplet N))))
