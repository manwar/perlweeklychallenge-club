(ns c222.t1-test
  (:require [clojure.test :refer [deftest is testing]]
            [c222.t1 :refer [matching-members]]))

(deftest task-1
  (testing "Task 1 produces the correct results from examples in the description"
    (is (= 3 (matching-members [1 1 4 2 1 3])))
    (is (= 0 (matching-members [5 1 2 3 4])))
    (is (= 5 (matching-members [1 2 3 4 5])))))
