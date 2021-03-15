(ns tw.weekly.c101.t2
  (:require [clojure.edn :as edn]))

;;;
; Task description for TASK #2 › Origin-containing Triangle
;;;

(def DEFAULT-INPUT [[0 1] [1 0] [2 2]])

(defn contains-origin
  "Determine if the triangle formed by the given three points cover the (0,0)
  origin on a 2D plane, using the Barycentric Coordinate Sytem method from
  https://totologic.blogspot.com/2014/01/accurate-point-in-triangle-test.html"
  [[x1 y1] [x2 y2] [x3 y3]]
  (let [denominator (+ (* (- y2 y3) (- x1 x3)) (* (- x3 x2) (- y1 y3)))
        A (/ (+ (* (- y2 y3) (- x3)) (* (- x3 x2) (- y3))) denominator)
        B (/ (+ (* (- y3 y1) (- x3)) (* (- x1 x3) (- y3))) denominator)
        C (- 1 A B)]
    (and (<= 0 A) (<= A 1)
         (<= 0 B) (<= B 1)
         (<= 0 C) (<= C 1))))

(defn -main
  "Run Task 2 points A, B, and C; defaulting to the example given in the
  task description."
  [& args]
  (let [[A B C] (or (some->> args (take 3) (map edn/read-string)) DEFAULT-INPUT)]
    (println (if (contains-origin A B C) 1 0))))
