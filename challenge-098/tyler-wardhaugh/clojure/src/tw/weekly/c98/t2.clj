(ns tw.weekly.c98.t2
  (:import java.util.Arrays)
  (:require [clojure.edn :as edn]))

;;;
; Task description for TASK #2 › Search Insert Position
;;;

(def DEFAULT-INPUT [[1 2 3 4] 3])

(defn search-insert-position
  "Find the search insert position for n into a sorted sequence of integers
  coll"
  [coll n]
  (let [index (Arrays/binarySearch (int-array coll) n)]
    (if (neg? index)
      (-> index - dec)
      index)))

(defn -main
  "Run Task 2 using a sorted sequence of integers NS and a target N,
  defaulting to the example given in the task description."
  [& args]
  (let [[NS N] (or (some->> args (take 2) (map edn/read-string)) DEFAULT-INPUT)]
    (println (search-insert-position NS N))))
