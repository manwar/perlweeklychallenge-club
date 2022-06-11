(ns c163.t1-test
  (:require [clojure.test :refer [deftest is testing]]
            [c163.t1 :refer [sum-bitwise]]))

(deftest task-1
  (testing "Task 1 produces the correct result"
    (is (= 3 (sum-bitwise [1 2 3])))
    (is (= 2 (sum-bitwise [2 3 4])))))
