(ns tw.weekly.c80-test
  (:require [clojure.test :refer [deftest is testing]]
            [tw.weekly.c80.t1 :refer [smallest-missing]]
            [tw.weekly.c80.t2 :refer [count-candies]]))

(deftest task-1
  (testing "Task 1, Smallest Positive Number Bits"
    (is (= (smallest-missing [5 2 -2 0]) 1))
    (is (= (smallest-missing [1 8 -1]) 2))
    (is (= (smallest-missing [2 0 -1]) 1))
    (is (= (smallest-missing [-5 -4 -3]) 1))
    (is (= (smallest-missing [1 2 3 (int 1e7)]) 4))
    (is (nil? (smallest-missing [1 4 2 3])))))

(deftest task-2
  (testing "Task 2, Count Candies"
    (is (= (count-candies [1, 2, 2]) 4))
    (is (= (count-candies [1, 4, 3, 2]) 7))))
