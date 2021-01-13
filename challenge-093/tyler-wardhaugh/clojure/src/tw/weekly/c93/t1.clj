(ns tw.weekly.c93.t1
  (:require [clojure.edn :as edn]
            [clojure.math.combinatorics :as combo]))

;;;
; Task description for TASK #1 › Max Points
;;;

(def DEFAULT-INPUT '((1,1), (2,2), (3,3)))

(defn slope
  "Calculate the slope between two points."
  [[[x1 y1] [x2 y2]]]
  (try (/ (- y1 y2) (- x1 x2))
       (catch ArithmeticException _ ##Inf)))

(defn max-points
  "Count maximum points on a straight line when given co-ordinates plotted on 2-d plane."
  [coll]
  (if (< (count coll) 3)
    (count coll)
    (let [source (group-by slope (combo/combinations coll 2))
          xf (map #(->> %
                        val
                        (apply concat)
                        frequencies
                        (map val)
                        (reduce max 0)))]
      (inc (transduce xf max 0 source)))))

(defn -main
  "Run Task 1 using a sequence of points, defaulting to the example given in
  the task description."
  [& args]
  (let [N (or (some-> args first edn/read-string) DEFAULT-INPUT)]
    (println (max-points N))))
