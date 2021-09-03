(ns tw.weekly.c126.t2
  (:require [clojure.edn :as edn]
            [clojure.java.io :as io]
            [clojure.string :as str]
            [clojure.core.matrix :as m]
            [tw.weekly.c126.matrix-util :as mu]))

;;;
; Task description for TASK #2 › Minesweeper Game
;;;
(def DEFAULT-INPUT [(io/resource "matrix.txt")])
(def MINE \x)
(def FREE \*)

(defn parse
  [f]
  (->> (mu/parse-matrix-file
         f
         (map (comp
                #(map edn/read-string %)
                #(str/split % #" ")
                #(str/escape % {MINE -1, FREE 0}))))
       (m/array :ndarry)))

(defn count-neighboring-mines [mat]
  (let [emat (mu/extend-matrix mat)]
    (fn [[i j] v]
      (if (neg? v)
        MINE
        (->> (m/submatrix emat i 3 j 3)
             m/eseq
             (filter neg?)
             count)))))

(defn minesweeper
  [mat]
  (m/emap-indexed (count-neighboring-mines mat) mat))

(defn -main
  "Run Task 2 with a given input, defaulting to the first example from the
  task description."
  [& args]
  (let [[F] (or (some->> args (map (comp io/file edn/read-string))) DEFAULT-INPUT)]
    (-> F parse minesweeper mu/print-matrix)))
