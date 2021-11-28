(ns tw.weekly.c140.t2
  (:require [clojure.edn :as edn]))

;;;
; Task description for TASK #2 › Multiplication Table
;;;
(def DEFAULT-INPUT [2 3 4])

(defn get-kth-in-multi
  [i j k]
  (-> (for [i (range 1 (inc i))
            j (range 1 (inc j))]
        (* i j))
      sort
      (nth (dec k))))

(defn -main
  "Run Task 2 with a given input I J K, defaulting to the first example from
  the task description."
  [& args]
  (let [[I J K] (or (some->> args (map edn/read-string)) DEFAULT-INPUT)]
    (println (get-kth-in-multi I J K))))
