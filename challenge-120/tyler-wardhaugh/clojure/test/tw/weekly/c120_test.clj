(ns tw.weekly.c120-test
  (:require [clojure.test :refer [deftest is testing]]
            [tw.weekly.c120.t1 :refer [swap-bits]]
            #_[tw.weekly.c120.t2 :refer [clock-angle]]))

(deftest task-1
  (testing "Task 1, Swap Odd/Even bits"
    (is (= 154 (swap-bits 101)))
    (is (= 101 (swap-bits 154)))
    (is (= 33 (swap-bits 18)))
    (is (= 18 (swap-bits 33)))))

(deftest task-2
  (testing "Task 2, Clock Angle"
    ))
