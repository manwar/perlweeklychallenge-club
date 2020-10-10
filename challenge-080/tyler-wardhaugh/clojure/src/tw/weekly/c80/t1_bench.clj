(ns tw.weekly.c80.t1-bench
  (:require [clojure.pprint :refer [cl-format]])
  (:require [tw.weekly.c80.t1 :as t1])
  (:require [criterium.core :as cc]))


(defn -main
  [& _]
  (doseq [t [[1 -2 8] [1 2 3] [1 2 3 (int 1e7)]]]
    (cl-format true "~2%===~a~60,1,0,'=a" t "=")

    (cl-format true "~2%Benchmarking ~a by set-intersection:~%" t)
    (cc/quick-bench (t1/smallest-missing-by-set-intersection t))

    (cl-format true "~2%Benchmarking ~a by sorting:~%" t)
    (cc/quick-bench (t1/smallest-missing-by-sorting t))

    (cl-format true "~2%Benchmarking ~a by set-membership:~%" t)
    (cc/quick-bench (t1/smallest-missing-by-set-membership t))))
