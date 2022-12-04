(ns c193.t1
  (:require [clojure.pprint :refer [cl-format]]))

(def DEFAULT-INPUT [2])

(defn binary-string
  [n]
  (->> (bit-shift-left 2 (dec n))
       range
       (map #(cl-format nil "~v,'0b" n %))))

(defn -main
  "Run Task 1 with a given input COLL, defaulting to the first example from
  the task description."
  [& args]
  (let [[N] (or (some->> args (map parse-long)) DEFAULT-INPUT)]
    (cl-format true "~{~a~^, ~}~%" (binary-string N))))
