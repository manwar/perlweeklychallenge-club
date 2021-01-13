(ns tw.weekly.c91-test
  (:require [clojure.test :refer [deftest is testing]]
            [tw.weekly.c91.t1 :refer [count-number]]
            [tw.weekly.c91.t2 :refer [jump-game]]))

(deftest task-1
  (testing "Task 1, Count Number"
    (is (= 21321314 (count-number 1122234)))
    (is (= 12332415 (count-number 2333445)))
    (is (= 1112131415 (count-number 12345)))))

(deftest task-2
  (testing "Task 2, Jump Game"
    (is (true? (jump-game [1 2 1 2])))
    (is (false? (jump-game [2 1 1 0 2])))))
