(ns c188.t1-test
  (:require [clojure.test :refer [deftest is testing]]
            [c188.t1 :refer [divisible-pairs]]))

(deftest task-1
  (testing "Task 1 produces the correct results"
    (is (= 2 (divisible-pairs [4 5 1 6] 2)))
    (is (= 2 (divisible-pairs [1 2 3 4] 2)))
    (is (= 2 (divisible-pairs [1 3 4 5] 3)))
    (is (= 2 (divisible-pairs [5 1 2 3] 4)))
    (is (= 1 (divisible-pairs [7 2 4 5] 4)))))
