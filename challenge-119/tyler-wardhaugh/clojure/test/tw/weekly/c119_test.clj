(ns tw.weekly.c119-test
  (:require [clojure.test :refer [deftest is testing]]
            [tw.weekly.c119.t1 :refer [swap-nibbles]]
            [tw.weekly.c119.t2 :refer [seq-sans-1on1]]))

(deftest task-1
  (testing "Task 1, Swap Nibbles"
    (is (= 101 (swap-nibbles 86)))
    (is (= 86 (swap-nibbles 101)))
    (is (= 33 (swap-nibbles 18)))
    (is (= 18 (swap-nibbles 33)))))

(deftest task-2
  (testing "Task 2, Sequence without 1-on-1"
    (is (= 13 (seq-sans-1on1 5)))
    (is (= 32 (seq-sans-1on1 10)))
    (is (= 2223 (seq-sans-1on1 60)))))
