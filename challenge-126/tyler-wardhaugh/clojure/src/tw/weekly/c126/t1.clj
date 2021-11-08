(ns tw.weekly.c126.t1
  (:require [clojure.edn :as edn]
            [clojure.string :as str]
            [clojure.pprint :refer [cl-format]]))

;;;
; Task description for TASK #1 › Count Numbers
;;;
(def DEFAULT-INPUT [15])

(defn count-numbers
  [n]
  (let [xf (remove #(str/includes? (str %1) "1"))
        ed (eduction xf (range 2 (inc n)))
        msg "There are ~a numbers between 1 and ~a that don't contain digit 1.~%~{~a~^, ~}"]
    (cl-format nil msg (count (seq ed)) n ed)))

(defn -main
  "Run Task 1 with a given input N, defaulting to the first example from the
  task description."
  [& args]
  (let [[N] (or (some->> args (map edn/read-string)) DEFAULT-INPUT)]
    (println (count-numbers N))))
