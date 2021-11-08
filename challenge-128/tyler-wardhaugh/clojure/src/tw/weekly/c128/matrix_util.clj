(ns tw.weekly.c128.matrix-util
  (:require [clojure.java.io :as io]
            [clojure.pprint :as pp]
            [clojure.string :as str]
            [clojure.core.matrix :as m]))

(defn parse-matrix-file
  "Parse a matrix file and return a matrix"
  ([matrix-file]
   (parse-matrix-file matrix-file (comp)))
  ([matrix-file xf]
   (with-open [in (io/reader matrix-file)]
     (into [] xf (line-seq in)))))

(defn extend-matrix
  "Surround the matrix in a 'border' of 0s. That is, add rows before the first and after the last rows and add columns before
  the first and after the last columns."
  [mat]
  (let [n (m/dimension-count mat 1)
        blank-row (vec (repeat (+ n 2) 0))
        step-1 (reduce (fn [mat v] (conj mat (vec (concat [0] v [0])))) [blank-row] mat)]
    (conj step-1 blank-row)))

(defn rotate-matrix
  "Rotate a matrix counterclockwise"
  [mat]
  (-> mat m/transpose reverse))

(defn print-matrix
  ([mat]
   (print-matrix mat true))
  ([mat stream]
   (pp/cl-format stream "~{[ ~{~a~^ ~} ]~%~}" mat)))

(defn pprint-matrix
  "Pretty print a matrix"
  [mat]
  (let [ks (range (m/dimension-count mat 1))
        tbl (with-out-str
              (pp/print-table ks (map (partial zipmap ks) mat)))]
    (-> tbl
        (str/split #"\n")
        (->> (drop 3)
             (run! println)))))
