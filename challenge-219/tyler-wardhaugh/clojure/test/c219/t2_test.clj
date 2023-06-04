(ns c219.t2-test
  (:require [clojure.test :refer [deftest is testing]]
            [c219.t2 :refer [travel-expenditure]]))

(deftest task-1
  (testing "Task 2 produces the correct results from examples in the description"
    (is (= 11 (travel-expenditure [2 7 25] [1 5 6 7 9 15])))
    (is (= 20 (travel-expenditure [2 7 25] [1 2 3 5 7 10 11 12 14 20 30 31])))))
