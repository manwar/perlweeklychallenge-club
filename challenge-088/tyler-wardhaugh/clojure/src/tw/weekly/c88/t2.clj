(ns tw.weekly.c88.t2
  (:require [tw.weekly.c88.util :as util])
  (:require [clojure.java.io :as io])
  (:require [clojure.pprint :refer [cl-format]])
  (:require [clojure.core.matrix :as m]))

;;;
; Task description for TASK #2 › Spiral Matrix
;;;

(defn make-matrix
  "Instantiate a matrix from a matrix file"
  [matrix-file]
  (-> matrix-file util/parse-matrix-file m/matrix))

(defn rotate-matrix
  "Rotate a matrix counterclockwise"
  [matrix]
  (-> matrix m/transpose reverse))

(defn spiral-matrix
  "Return a sequence of matrix items in spiral order."
  [matrix]
  (when (m/eseq matrix)
    (let [row (m/get-row matrix 0)
          remaining-rows (-> matrix (m/select :rest :all) m/rows)]
      (concat row (-> remaining-rows rotate-matrix spiral-matrix)))))

(defn -main
  "Run Task 2 with a given file containing a matrix, defaulting
  to the example given in the task description."
  [& args]
  (let [matrix-file (or (some-> args first io/file) (io/resource "matrix-1"))
        mseq (-> matrix-file make-matrix spiral-matrix)]
    (cl-format true "[ ~{~a~^, ~} ]~%" mseq)))
