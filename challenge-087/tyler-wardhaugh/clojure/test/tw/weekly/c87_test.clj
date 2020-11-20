(ns tw.weekly.c87-test
  (:require [clojure.test :refer [deftest is testing]]
            [clojure.java.io :as io]
            [tw.weekly.c87.t1 :refer [find-lcs]]
            [tw.weekly.c87.t2 :refer [find-largest-rectangle parse-matrix-file]]))

(deftest task-1
  (testing "Task 1 Longest Consecutive Sequence"
    (is (= [2 4] (find-lcs [100 4 50 3 2])))
    (is (= [0 0] (find-lcs [20 30 10 40 50])))
    (is (= [9 11] (find-lcs [20 19 9 11 10])))))

(def task-2-helper
  ^{:doc "Solve Task 2, returning a vector of the largest (height, width)"}
  (comp find-largest-rectangle parse-matrix-file io/resource))

(deftest task-2
  (testing "Task 2 Largest Rectangle"
    (is (= [2 5] (task-2-helper "matrix-1")))
    (is (= [1 1] (task-2-helper "matrix-2")))
    (is (= [2 4] (task-2-helper "matrix-3")))))
