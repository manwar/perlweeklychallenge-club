(ns tw.weekly.c80-test
  (:require [clojure.test :refer [deftest is testing]]
            [tw.weekly.c80.t1 :refer [smallest-missing]]))

(deftest task-1
  (testing "Task 1, Smallest Positive Number Bits"
    (is (= (smallest-missing [5 2 -2 0]) 1))
    (is (= (smallest-missing [1 8 -1]) 2))
    (is (= (smallest-missing [2 0 -1]) 1))
    (is (nil? (smallest-missing [1 2 3])))))
