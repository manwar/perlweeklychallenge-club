(ns tw.weekly.c88.util
  (:require [clojure.java.io :as io])
  (:require [clojure.edn :as edn]))

(defn parse-matrix-file
  "Parse a matrix file and return a matrix"
  [matrix-file]
  (with-open [in (io/reader matrix-file)]
    (-> (slurp in)
        (as-> x (str \[ x \]))
        edn/read-string)))
