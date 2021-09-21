(ns tw.weekly.c131-test
  (:require [clojure.test :refer [deftest is testing]]
            [tw.weekly.c131.t1 :refer [split-consecutive]]
            #_[tw.weekly.c131.t2 :refer []]))

(deftest task-1
  (testing "Task 1, Consecutive Arrays"
    (is (= '((1 2 3) (6 7 8 9)) (split-consecutive '(1, 2, 3, 6, 7, 8, 9))))
    (is (= '((11 12) (14) (17 18 19)) (split-consecutive '(11, 12, 14, 17, 18, 19))))
    (is (= '((2) (4) (6) (8)) (split-consecutive '(2, 4, 6, 8))))
    (is (= '((1 2 3 4 5)) (split-consecutive '(1, 2, 3, 4, 5))))))

(deftest task-2
  )
