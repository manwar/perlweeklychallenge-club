(ns c218.t1-test
  (:require [clojure.test :refer [deftest is testing]]
            [c218.t1 :refer [max-product]]))

(deftest task-1
  (testing "Task 1 produces the correct results from examples in the description"
    (is (= 6 (max-product [3 1 2])))
    (is (= 24 (max-product [4 1 3 2])))
    (is (= 3 (max-product [-1 0 1 3 1])))
    (is (= 216 (max-product [-8 2 -9 -4 3])))))
