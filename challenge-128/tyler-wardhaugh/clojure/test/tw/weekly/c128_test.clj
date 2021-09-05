(ns tw.weekly.c128-test
  (:require [clojure.test :refer [deftest is testing]]
            [clojure.java.io :as io]
            [tw.weekly.c128.t1 :as t1]
            #_[tw.weekly.c128.t2 :as t2]))

(defn solve-t1
  [f]
  (-> f io/resource t1/parse t1/find-max-submatrix))

(deftest task-1
  (testing "Task 1, Maximum Sub-Matrix"
    (is (= [2 3] (solve-t1 "matrix1.txt")))
    (is (= [3 2] (solve-t1 "matrix2.txt")))))

(deftest task-2
  (testing "Task 2, Minimum Platforms"
    ))
