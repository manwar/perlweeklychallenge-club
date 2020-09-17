(ns tw.weekly.c78-test
  (:require [clojure.test :refer [deftest is testing]]
            [tw.weekly.c78.t1 :refer [leader-elements]]
            [tw.weekly.c78.t2 :refer [rotate-by-list]]))

(deftest task-1
  (testing "Task 1, Leader Elements"
    (is (= (leader-elements [9, 10, 7, 5, 6, 1]) (list 10 7 6 1)))
    (is (= (leader-elements [3 4 5]) (list 5)))))

(deftest task-2
  (testing "Task 2, Left Rotation"
    (is (= [[40 50 10 20 30], [50 10 20 30 40]] (rotate-by-list [10 20 30 40 50] [3 4])))
    (is (= [[4 2 6 3 7], [6 3 7 4 2], [3 7 4 2 6]] (rotate-by-list [7 4 2 6 3] [1 3 4])))))
