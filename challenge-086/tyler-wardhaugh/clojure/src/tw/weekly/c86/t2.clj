(ns tw.weekly.c86.t2
  (:require [clojure.edn :as edn])
  (:require [clojure.java.io :as io])
  (:require [clojure.pprint :refer [cl-format]])
  (:require [clojure.core.matrix :as m])
  (:require [clojure.core.logic :as l])
  (:require [clojure.core.logic.fd :as fd]))

;;;
; Task description for TASK #2 › Sudoku Puzzle
;;;

(defn parse-sudoku-file
  "Parse a sudoku file and return a matrix"
  [sudoku-file]
  (with-open [in (io/reader sudoku-file)]
    (edn/read-string (str \[ (slurp in) \]))))

(defn solve
  "Solve the sudoku puzzle"
  [sudoku]
  (let [board (m/emap (fn [x] (if (= '_ x) (l/lvar) x)) sudoku)
        subsquares (for [x (range 0 9 3)
                         y (range 0 9 3)]
                     (m/eseq (m/submatrix board x 3 y 3)))]
  (first
    (l/run 1 [q]
           (l/== q board)
           (l/everyg (fn [q] (fd/in q (fd/interval 1 9))) (m/eseq board))
           (l/everyg fd/distinct (m/rows board))
           (l/everyg fd/distinct (m/columns board))
           (l/everyg fd/distinct subsquares)))))

(defn -main
  "Run Task 2 with a given file containing a sudoku puzzle, defaulting
  to the example given in the task description."
  [& args]
  (let [sudoku-file (or (some-> args first io/file) (io/resource "sudoku-1"))
        sudoku (parse-sudoku-file sudoku-file)
        solution (solve sudoku)]
    (cl-format true "~:[No solution found~;~:*~{~a~^~%~}~]~%" solution)))
