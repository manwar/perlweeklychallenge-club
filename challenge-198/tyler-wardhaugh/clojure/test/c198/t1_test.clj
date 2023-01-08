(ns c198.t1-test
  (:require [clojure.test :refer [deftest is testing]]
            [c198.t1 :refer [max-gap]]))

(deftest task-1
  (testing "Task 1 produces the correct results from examples in the description"
    (is (= 2 (max-gap [2 5 8 1])))
    (is (zero? (max-gap [3]))))
  (testing "Task 1 is correct for additional inputs"
    (is (zero? (max-gap [])))))
