(ns c191.t1-test
  (:require [clojure.test :refer [deftest is testing]]
            [c191.t1 :refer [twice-largest]]))

(deftest task-1
  (testing "Task 1 produces the correct results (description)"
    (is (false? (twice-largest [1 2 3 4])))
    (is (true? (twice-largest [1 2 0 5])))
    (is (true? (twice-largest [2 6 3 1])))
    (is (false? (twice-largest [4 5 2 3])))))

(deftest task-1
  (testing "Additional tests for twice-largest"
    (is (nil? (twice-largest [1])))
    (is (nil? (twice-largest [])))))
