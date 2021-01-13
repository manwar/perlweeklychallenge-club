(ns tw.weekly.c72.t1
  (:require [clojure.pprint :refer [cl-format]])
  (:require [clojure.edn :as edn]))

(defn fact
  "Factorial"
  [n]
  (->> n inc (range 1) (reduce *)))

(defn trailing-zeros
  "Count the trailing 0s in a number"
  [n]
  (let [[d cnt] (->> n str reverse (partition-by #(= \0 %)) first ((juxt first count)))]
    (if (= d \0) cnt 0)))

(defn -main
  "Run Task 1 with a number N, defaulting to 10"
  [& args]
  (let [n (or (some-> args first edn/read-string) 10)
        n! (fact n)
        zs (trailing-zeros n!)]
    (cl-format true "~a! = ~a has ~a trailing zero~:p" n n! zs)))
