(ns c199.t1-test
  (:require [clojure.test :refer [deftest is testing]]
            [c199.t1 :refer [good-pairs]]))

(deftest task-1
  (testing "Task 1 produces the correct results from examples in the description"
    (is (= 4 (good-pairs [1 2 3 1 1 3])))
    (is (= 0 (good-pairs [1 2 3])))
    (is (= 6 (good-pairs [1 1 1 1])))))
