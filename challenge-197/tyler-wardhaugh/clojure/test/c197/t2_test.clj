(ns c197.t2-test
  (:require [clojure.test :refer [deftest is testing]]
            [c197.t2 :refer [wiggle-sort]]))

(deftest task-2
  (testing "Task 2 produces the correct results"
    (is (= (wiggle-sort [1 5 1 1 6 4]) [1 6 1 5 1 4]))
    (is (= (wiggle-sort [1 3 2 2 3 1]) [2 3 1 3 1 2]))))
