(ns tw.weekly.util.matrix
  (:require [clojure.pprint :as pp]
            [clojure.string :as str]
            [clojure.core.matrix :as m]))

(defn rotate-matrix
  "Rotate a matrix counterclockwise"
  [mat]
  (-> mat m/transpose reverse))

(defn print-matrix
  "Pretty print a matrix"
  [mat]
  (let [ks (range (m/dimension-count mat 1))
        tbl (with-out-str
              (pp/print-table ks (map (partial zipmap ks) mat)))]
    (-> tbl
        (str/split #"\n")
        (->> (drop 3)
             (run! println)))))
