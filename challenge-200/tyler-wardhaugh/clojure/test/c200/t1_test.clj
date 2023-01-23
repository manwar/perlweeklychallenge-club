(ns c200.t1-test
  (:require [clojure.test :refer [deftest is testing]]
            [c200.t1 :refer [arithmetic-slices]]))

(deftest task-1
  (testing "Task 1 produces the correct results from examples in the description"
    (is (= [[1 2 3] [2 3 4] [1 2 3 4]] (arithmetic-slices [1 2 3 4])))
    (is (= [] (arithmetic-slices [2])))))
