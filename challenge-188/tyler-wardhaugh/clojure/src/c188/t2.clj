(ns c188.t2
  (:require [clojure.edn :as edn]))

(def DEFAULT-INPUT [5 4])

(defn total-zero
  [x y]
  (loop [x x
         y y
         ops 0]
    (if (= 0 x y)
      (dec ops)
      (let [[x' x-ops] (if (<= y x) [(- x y) 1] [x 0])
            [y' y-ops] (if (<= x y) [(- y x) 1] [y 0])]
        (recur x' y' (+ ops x-ops y-ops))))))

(defn -main
  "Run Task 2 with a given input X and Y, defaulting to the first example from
  the task description."
  [& args]
  (let [[X Y] (or (some->> args (map edn/read-string)) DEFAULT-INPUT)]
    (println (total-zero X Y))))
