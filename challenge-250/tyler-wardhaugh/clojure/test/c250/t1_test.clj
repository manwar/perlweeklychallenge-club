(ns c250.t1-test
  (:require [clojure.test :refer [deftest is testing]]
            [c250.t1 :refer [smallest-index]]))

(deftest task-1
  (testing "Task 1 produces the correct results from examples in the description"
    (is (= 0 (smallest-index [0 1 2])))
    (is (= 2 (smallest-index [4 3 2 1])))
    (is (= -1 (smallest-index [1 2 3 4 5 6 7 8 9 0])))))
