(ns c146.t1b)

(def TARGET 10001)

(defn nth-prime
  [n]
  (nth (iterate #(.nextProbablePrime %) BigInteger/ONE) n))

(defn -main
  [& _]
  (println (nth-prime TARGET)))
