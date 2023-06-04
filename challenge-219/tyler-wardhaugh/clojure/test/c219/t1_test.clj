(ns c219.t1-test
  (:require [clojure.test :refer [deftest is testing]]
            [c219.t1 :refer [sorted-squares]]))

(deftest task-1
  (testing "Task 1 produces the correct results from examples in the description"
    (is (= [0 1 4 9 16] (sorted-squares [-2 -1 0 3 4])))
    (is (= [1 9 16 25 36] (sorted-squares [5 -4 -1 3 6])))))
