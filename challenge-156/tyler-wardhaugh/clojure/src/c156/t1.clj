(ns c156.t1
  (:require [clojure.pprint :refer [cl-format]]))

(defn pernicious?
  [n]
  (let [ones (BigInteger/valueOf (.bitCount (BigInteger/valueOf n)))]
    (.isProbablePrime ones 1000)))

(defn -main
  "Run Task 1."
  [& args]
  (cl-format true "~{~a~^, ~}~%" (->> (range) (filter pernicious?) (take 10))))
