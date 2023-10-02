(ns c223.t2-test
  (:require [clojure.test :refer [deftest is testing]]
            [c223.t2 :refer [box-coins]]))

(deftest task-1
  (testing "Task 2 produces the correct results from examples in the description"
    (is (= 167 (box-coins [3 1 5 8])))
    (is (= 10 (box-coins [1 5])))))
