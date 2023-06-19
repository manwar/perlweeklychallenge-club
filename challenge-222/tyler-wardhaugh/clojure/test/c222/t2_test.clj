(ns c222.t2-test
  (:require [clojure.test :refer [deftest is testing]]
            [c222.t2 :refer [last-member]]))

(deftest task-1
  (testing "Task 2 produces the correct results from examples in the description"
    (is (= 1 (last-member [2 7 4 1 8 1])))
    (is (= 1 (last-member [1])))
    (is (= 0 (last-member [1 1])))))
