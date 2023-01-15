(ns c199.t2-test
  (:require [clojure.test :refer [deftest is testing]]
            [c199.t2 :refer [good-triplets]]))

(deftest task-2
  (testing "Task 2 produces the correct results from examples in the description"
    (is (= 4 (good-triplets 7 2 3 [3 0 1 1 9 7])))
    (is (= 0 (good-triplets 0 0 1 [1 1 2 2 3])))))
