(ns tw.weekly.c128.t1
  (:require [clojure.edn :as edn]
            [clojure.java.io :as io]
            [clojure.string :as str]
            [clojure.pprint :refer [cl-format]]
            [clojure.core.matrix :as m]
            [tw.weekly.c128.matrix-util :as mu]))

;;;
; Task description for TASK #1 › Maximum Sub-Matrix
;;;
(def DEFAULT-INPUT [(io/resource "matrix1.txt")])

(defn parse
  [f]
  (->> (mu/parse-matrix-file f (map edn/read-string))
       (m/array :ndarry)))

(defn find-max-submatrix
  [mat]
  (let [source (m/index-seq mat)
        [m n] (m/shape mat)
        gen-subm (fn [[i j]]
                   (when (zero? (m/mget mat i j))
                     (for [x (range i (inc m))
                           y (range j (inc n))
                           :let [subm (m/submatrix mat i (- x i) j (- y j))]
                           :when (m/zero-matrix? subm)]
                       (m/shape subm))))
        xf (comp (map gen-subm) (filter seq) cat)
        f (completing (fn [w v] (max-key (partial apply *) w v)))]
    (transduce xf f [0 0] source)))

(defn -main
  "Run Task 1 with a given input M, defaulting to the first example from the
  task description."
  [& args]
  (let [[F] (or (some->> args (map (comp io/file edn/read-string))) DEFAULT-INPUT)
        [m n] (-> F parse find-max-submatrix)]
    (-> (m/zero-matrix :ndarry m n) (m/fill 0) mu/print-matrix)))
