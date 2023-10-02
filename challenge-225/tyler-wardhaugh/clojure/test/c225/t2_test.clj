(ns c225.t2-test
  (:require [clojure.test :refer [deftest is testing]]
            [c225.t2 :refer [left-right-sum-diff]]))

(deftest task-1
  (testing "Task 2 produces the correct results from examples in the description"
    (is (= (left-right-sum-diff [10 4 8 3]) [15 1 11 22]))
    (is (= (left-right-sum-diff [0]) [0]))
    (is (= (left-right-sum-diff [1 2 3 4 5]) [14 11 6 1 10]))))
