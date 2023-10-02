(ns c233.t2-test
  (:require [clojure.test :refer [deftest is testing]]
            [c233.t2 :refer [freq-sort]]))

(deftest task-1
  (testing "Task 2 produces the correct results from examples in the description"
    (is (= [3 1 1 2 2 2] (freq-sort [1 1 2 2 2 3])))
    (is (= [1 3 3 2 2] (freq-sort [2 3 1 3 2])))
    (is (= [5 -1 4 4 -6 -6 1 1 1] (freq-sort [-1 1 -6 4 5 -6 1 4 1])))))
