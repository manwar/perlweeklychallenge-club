(ns c197.t1-test
  (:require [clojure.test :refer [deftest is testing]]
            [c197.t1 :refer [move-zero]]))

(deftest task-1
  (testing "Task 1 produces the correct results (description)"
    (is (= (move-zero [1 0 3 0 0 5]) [1 3 5 0 0 0]))
    (is (= (move-zero [1 6 4]) [1 6 4]))
    (is (= (move-zero [0 1 0 2 0]) [1 2 0 0 0]))))
