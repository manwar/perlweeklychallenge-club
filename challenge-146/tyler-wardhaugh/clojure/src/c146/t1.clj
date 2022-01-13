(ns c146.t1)

(def TARGET 10001)

(defn nth-prime
  [n]
  (let [p (promise)
        sieve (fn [n]
                (not-any? #(zero? (rem n %))
                          (take-while #(<= (* % %) n) @p)))]
    (->> @(deliver p (filter sieve (iterate inc 2)))
         (drop (dec n))
         first)))

(defn -main
  [& _]
  (println (nth-prime TARGET)))
