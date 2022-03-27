(ns c157.t2
  (:require [clojure.edn :as edn]
            [clojure.pprint :refer [cl-format]]))

(def DEFAULT-INPUT [7])

(defn- check-by-base
  [n]
  (->> (range 2 (dec n))
       (filter
         (fn [b]
           (== 1 (-> n BigInteger/valueOf (.toString b) distinct count))))
       (some identity)
       boolean))

(defn brazilian? [n]
  (cond
    (< n 7) false
    (and (even? n) (>= n 8)) true
    :else (check-by-base n)))

(defn -main
  "Run Task 2 with a given input N, defaulting to the first example from the
  task description."
  [& args]
  (let [[N] (or (some->> args (map edn/read-string)) DEFAULT-INPUT)]
    (println (if (brazilian? N) 1 0))))
