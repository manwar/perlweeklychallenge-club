(ns c154.t2
  (:require [clojure.pprint :refer [cl-format]]))

(defn padovans
  []
  (let [p (promise)]
    @(doto p
       (deliver (list* 1 1 1 (lazy-seq (map + @p (rest @p))))))))

(defn gen-padovan-primes
  []
  (->> (padovans)
       (filter #(.isProbablePrime (BigInteger/valueOf %) 1000))
       (drop 1)))

(def first-ten-distinct-padovan-primes (take 10 (gen-padovan-primes)))

(defn -main
  "Run Task 2."
  [& args]
  (cl-format true "~{~a~^, ~}~%" first-ten-distinct-padovan-primes))
