(ns tw.weekly.ch-2
  (:require [clojure.pprint :refer [cl-format]])
  (:require [clojure.edn :as edn]))

(defn smallest-neighbor
  "Find the smallest neighbor over a sequence, returning 0 when none is found."
  [coll]
  (let [min-or-zero (fn [coll]
                      (let [m (apply min coll)]
                        (if (< m (peek coll)) m 0)))]
    (->> coll
         (reductions conj [])
         (drop 1)
         (map min-or-zero))))


 (defn -main
  "Run Task 2 a list of integers (A), defaulting to the example given in the task description."
  [& args]
  (let [A (or (some->> args (map edn/read-string)) [7 8 3 12 10])]
    (cl-format true "~10a: (~{~a~^ ~})~%~10a: (~{~a~^ ~})~%"
               "Input" A
               "Output" (smallest-neighbor A))))
