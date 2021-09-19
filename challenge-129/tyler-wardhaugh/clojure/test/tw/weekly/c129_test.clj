(ns tw.weekly.c129-test
  (:require [clojure.test :refer [deftest is testing]]
            [tw.weekly.c129.t1 :refer [root-distance]]
            #_[tw.weekly.c129.t2 :refer []]))

(def tree-1 '(1 (2) (3 nil (4 (5) (6)))))
(def tree-2 '(1 (2 (4 nil (6 (8) (9)))) (3 nil (5 (7)))))

(deftest task-1
  (testing "Task 1, Root Distance"
    (is (= 3 (root-distance tree-1 6)))
    (is (= 3 (root-distance tree-1 5)))
    (is (= 1 (root-distance tree-1 2)))
    (is (= 2 (root-distance tree-1 4)))
    (is (= 3 (root-distance tree-2 7)))
    (is (= 4 (root-distance tree-2 8)))
    (is (= 3 (root-distance tree-2 6)))))

(deftest task-2
  (testing "Task 2, Add Linked Lists"))
