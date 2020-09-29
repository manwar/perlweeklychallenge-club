(ns tw.weekly.c80.t1-bench
  (:require [clojure.pprint :refer [cl-format]])
  (:require [tw.weekly.c80.t1 :as t1])
  (:require [criterium.core :as cc]))


(defn -main
  [& _]
  (doseq [t [[1 -2 8] [1 2 3] [1 2 3 (int 1e7)]]]
    (cl-format true "Benchmarking ~a by-set:~%" t)
    (cc/quick-bench (t1/smallest-missing-by-set t))

    (Thread/sleep 1000)

    (cl-format true "Benchmarking ~a by-sorting~%" t)
    (cc/quick-bench (t1/smallest-missing-by-sorting t))))
