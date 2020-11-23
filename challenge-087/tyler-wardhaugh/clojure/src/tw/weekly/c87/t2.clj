(ns tw.weekly.c87.t2
  (:require [clojure.edn :as edn])
  (:require [clojure.java.io :as io])
  (:require [clojure.pprint :refer [cl-format]])
  (:require [clojure.core.matrix :as m]))

;;; algorithm sources:
;     GeeksforGeeks, https://www.geeksforgeeks.org/maximum-size-rectangle-binary-sub-matrix-1s/
;     Abigail, https://programmingblog702692439.wordpress.com/2020/11/20/perl-weekly-challenge-87-part-2/


;;;
; Task description for TASK #2 › Largest Rectangle
;;;

(defn parse-matrix-file
  "Parse a matrix file and return a matrix"
  [matrix-file]
  (with-open [in (io/reader matrix-file)]
    (-> (slurp in)
        (as-> x (str \[ x \]))
        edn/read-string
        m/matrix)))

(defn populate-sum-matrix
  "Create a matrix where each cell represents a sum of continuous 1s below it."
  [matrix]
  (let [sums (-> matrix reverse m/mutable)
        rows (m/rows sums)]
    (loop [prev (first rows)
           [curr & remaining] (rest rows)]
      (if curr
        (do 
          (m/emap-indexed! (fn [[y] v] (* v (inc (nth prev y)))) curr)
          (recur curr remaining))
        (reverse sums)))))

(defn non-zero-coords-and-vals
  "Generate a seq of coordinates and values in the form [x y value] for every
  non-zero value in the given matrix"
  [matrix]
  (->> (m/coerce [] matrix)
       (m/emap-indexed (fn [[x y] v] (when (pos? v) (vector x y v))))
       (apply concat)
       (keep identity)))

(def area ^{:doc "Calculate the area of a rectangle"} (partial apply *))

(defn best-rect-helper
  "A helper function to find the best (largest) rectangle"
  [[s n best] [x y value]]
  (let [initial [value (if (< (area best) value) [value 1] best)]
        f (fn [[min-depth best] w]
            (if (and (< (+ y w) n) (pos? (m/mget s x (+ y w))))
              (let [md-cand (m/mget s x (+ y w))]
                (vector (min md-cand min-depth)
                        (max-key area [min-depth (inc w)] best)))
              (reduced [min-depth best])))]
    [s n (->> (iterate inc 1) (reduce f initial) second)]))

(defn find-largest-rectangle
  "Find the largest rectangle in the given matrix"
  [matrix]
  (let [too-wide (apply < (m/shape matrix))
        sums (populate-sum-matrix (if too-wide (m/transpose matrix) matrix))
        largest (->> (non-zero-coords-and-vals sums)
                     (reduce best-rect-helper [sums (m/dimension-count sums 1) [0 0]])
                     last)]
    (if too-wide (reverse largest) largest)))

(defn flesh-out
  "Expand [m n] to a matrix of 1s"
  [[m n]]
  (m/to-nested-vectors (m/assign (m/zero-matrix m n) 1)))

(defn -main
  "Run Task 2 with a given file containing a matrix, defaulting
  to the example given in the task description."
  [& args]
  (let [matrix-file (or (some-> args first io/file) (io/resource "matrix-1"))
        matrix (parse-matrix-file matrix-file)
        solution (find-largest-rectangle matrix)]
    (if (<= (area solution) 1)
      (println 0)
      (cl-format true "~{~a~^~%~}~%" (flesh-out solution)))))
