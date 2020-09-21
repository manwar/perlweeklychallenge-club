(ns tw.weekly.c78.t1
  (:require [clojure.pprint :refer [cl-format]])
  (:require [clojure.edn :as edn]))

;;; Task description for TASK #1 › Leader Element
; You are given an array @A containing distinct integers.
;
; Write a script to find all leader elements in the array @A. Print (0) if none found.
;
; An element is leader if it is greater than all the elements to its right side.
;;;

(defn leader-elements
  "Find the leader elements of the given coll."
  [coll]
  (->> (reverse coll)
       (reduce (fn [xs x] (if (apply >= x xs) (conj xs x) xs)) (list))))

(defn -main
  "Run Task 1 with a list of numbers A, defaulting to the first example in the description"
  [& args]
  (let [A (or (some->> args (map edn/read-string)) [9, 10, 7, 5, 6, 1])
        leaders (leader-elements A)]
    (cl-format true "(~{~a~^, ~})" (or leaders 0))))
