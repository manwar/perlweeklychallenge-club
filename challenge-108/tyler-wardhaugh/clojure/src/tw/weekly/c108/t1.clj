(ns tw.weekly.c108.t1
  (:require [clojure.pprint :refer [cl-format]]))

;;;
; Task description for TASK #1 › Locate Memory
;;;

(def myvar 0)

(defn -main
  "Run Task 1."
  [& _]
  (let [hashcode (System/identityHashCode myvar)]
    (cl-format true "~a: value=~a hashcode=~a~%" #'myvar myvar hashcode)))
