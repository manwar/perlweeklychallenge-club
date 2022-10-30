(ns c188.t2-test
  (:require [clojure.test :refer [deftest is testing]]
            [c188.t2 :refer [total-zero]]))

(deftest task-2
  (testing "Task 2 produces the correct results"
    (is (= 5 (total-zero 5 4)))
    (is (= 3 (total-zero 4 6)))
    (is (= 4 (total-zero 2 5)))
    (is (= 3 (total-zero 3 1)))
    (is (= 5 (total-zero 7 4)))))
