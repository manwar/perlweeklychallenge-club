(ns tw.weekly.ch-2
  (:require [clojure.java.io :as io])
  (:require [clojure.string :as str])
  (:require [clojure.core.matrix :as mat])
  (:require [pjstadig.reducible-stream :refer [decode-lines!]]))

;;; Task description
; TASK #2 › Lonely X
; You are given m x n character matrix consists of O and X only.
;
; Write a script to count the total number of X surrounded by O only. Print 0 if none found.
;;;

(defn parse-matrix-file
  "Parse matrix file and convert 'O's to 0s and 'X's to 1s. Return a multidimensional vector of ints."
  [matrix-file]
  (let [source (decode-lines! matrix-file)
        xf (comp (map #(str/split % #"\s+")) (map #(replace {"O" 0, "X" 1} %)))]
    (into [] xf source)))

(defn extend-matrix
  "Surround the matrix in a 'border' of 0s. That is, add rows before the first and after the last rows and add columns before the first and after the last columns."
  [matrix]
  (let [n (mat/dimension-count matrix 1)
        blank-row (vec (repeat (+ n 2) 0))
        step-1 (reduce (fn [mat v] (conj mat (vec (concat [0] v [0])))) [blank-row] matrix)]
    (to-array-2d (conj step-1 blank-row))))

(defn find-lonelies
  "Find lonely values in a matrix."
  [matrix]
  (let [[m n] (mat/shape matrix)
        extended (extend-matrix matrix)]
    (for [x (range 1 (inc m))
          y (range 1 (inc n))
          :when (= 1 (aget extended x y))
          :let [submat (mat/submatrix extended [[(- x 1) 3] [(- y 1) 3]])]
          :when (= 1 (mat/esum submat))]
      [x y])))

(defn -main
  "Run Task 2 with a matrix file, defaulting to the 'matrix1.txt' file under the resources directory."
  [& args]
  (let [matrix-file (or (some-> args first io/file) (io/resource "matrix1.txt"))
        matrix (parse-matrix-file matrix-file)]
    (if-let [lonlies (find-lonelies matrix)]
      (do
        (printf "%d\n\nCoordinates:\n============\n" (count lonlies))
        (run! println lonlies))
      (println "No lonely Xs in matrix."))))
