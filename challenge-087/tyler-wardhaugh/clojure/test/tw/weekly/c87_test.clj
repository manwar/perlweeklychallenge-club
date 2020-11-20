(ns tw.weekly.c86-test
  (:require [clojure.test :refer [deftest is testing]]
            [clojure.java.io :as io]
            [tw.weekly.c87.t1 :refer [find-lcs]]))

(deftest task-1
  (testing "Task 1 Longest Consecutive Sequence"
    (is (= [2 4] (find-lcs [100 4 50 3 2])))
    (is (= [0 0] (find-lcs [20 30 10 40 50])))
    (is (= [9 11] (find-lcs [20 19 9 11 10])))))
