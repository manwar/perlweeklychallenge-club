(ns tw.weekly.c130-test
  (:require [clojure.test :refer [deftest is testing]]
            [tw.weekly.c130.t1 :refer [odd-one-out]]
            [tw.weekly.c130.t2 :refer [bst?]]))

(deftest task-1
  (testing "Task 1, Odd Number"
    (is (= (odd-one-out [2 5 4 4 5 5 2]) 5))
    (is (= (odd-one-out [1 2 3 4 3 2 1 4 4]) 4))))

(deftest task-2
  (testing "Task 2, Binary Search Tree"
    (is (true? (bst? '(8 (5 (4) (6)) (9)))))
    (is (false? (bst? '(5 (4 (3) (6)) (7)))))))
