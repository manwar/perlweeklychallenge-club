(ns c150.t2
  (:require [clojure.math :as m]
            [clojure.pprint :refer [cl-format]]))

(def TARGET 500)

(defn prime-squares-upto
  [ceiling]
  (let [source (iterate #(.nextProbablePrime %) BigInteger/ONE)
        xf (comp (drop 1) (take-while #(< % ceiling)) (map #(m/pow % 2)))]
    (into [] xf source)))

(defn square-free-ints
  [n]
  (let [prime-squares (prime-squares-upto (m/sqrt n))
        square-free? (fn [x] (not-any? #(zero? (rem x %)) prime-squares))]
    (->> (range 1 (inc n))
         (filter square-free?))))

(defn -main
  [& _]
  (cl-format true "~{~<~%~1,78:;~A~;~^,~> ~}" (square-free-ints TARGET)))
