(ns tw.weekly.c84.t2
  (:require [clojure.java.io :as io])
  (:require [clojure.string :as str])
  (:require [clojure.core.matrix :as mat])
  (:require [net.cgrand.xforms.io :as xio]))

;;; Task description for TASK #2 › Find Square
; Submitted by: Mohammad S Anwar
;
; You are given matrix of size m x n with only 1 and 0.
;
; Write a script to find the count of squares having all four corners set as 1.
;
;;;

(defn parse-matrix-file
  "Parse matrix file Return a multidimensional vector of ints."
  [matrix-file]
  (let [source (xio/lines-in matrix-file)
        xf (map (fn [s] (map #(Integer/parseInt %) (str/split s #"\s+"))))]
    (to-array-2d (into [] xf source))))

(defn get-corners
  "Get the four corners of a square given top-left coordinates [x, y] and a delta (dt)"
  [matrix x y dt]
  (let [coords [[x y], [(+ x dt) y], [x (+ y dt)], [(+ x dt) (+ y dt)]]]
    (mat/select-indices matrix coords)))

(defn find-squares
  "Find the number of squares having all four corners set as 1"
  [matrix]
  (let [[m n] (mat/shape matrix)]
    (for [[x y] (mat/index-seq-for-shape [m n])
          :when (pos? (mat/mget matrix x y))
          dt (range 1 (min (- m x) (- n y)))
          :when (every? pos? (get-corners matrix x y dt))]
      [x y dt])))

(defn -main
  "Run Task 2 with an array of integers, defaulting to the example given in the task description."
  [& args]
  (let [matrix-file (or (some-> args first io/file) (io/resource "matrix-1"))
        matrix (parse-matrix-file matrix-file)
        squares (find-squares matrix)]
    (println (count squares))))
