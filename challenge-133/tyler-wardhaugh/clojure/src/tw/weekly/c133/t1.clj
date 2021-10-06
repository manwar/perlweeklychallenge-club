(ns tw.weekly.c133.t1
  (:require  [clojure.edn :as edn]))

;;;
; Task description for TASK #1 › Integer Square Root
;;;
(def DEFAULT-INPUT [10])

(defn isqrt-easy
  "Return the integer square root of n, the easy way."
  [n]
  (int (Math/sqrt n)))

(defn isqrt
  "Return the integer square root of n, a slightly more manual way."
  [n]
  (let [x (quot n 2)
        next-x (fn [x] (quot (+ x (quot n x)) 2))
        xf (comp
             (partition-all 2)
             (drop-while (partial apply not=)))]
    (->> (iterate next-x x)
         (sequence xf)
         ffirst)))

(defn -main
  "Run Task 1 with a given input N, defaulting to the first example from the
  task description."
  [& args]
  (let [[N] (or (some->> args (map edn/read-string)) DEFAULT-INPUT)]
    (println (isqrt N))))
