(ns c217.t2-test
  (:require [clojure.test :refer [deftest is testing]]
            [c217.t2 :refer [max-number]]))

(deftest task-2
  (testing "Task 2 produces the correct results from examples in the description"
    (is (= 231 (max-number [1 23])))
    (is (= 3210 (max-number [10 3 2])))
    (is (= 431210 (max-number [31 2 4 10])))
    (is (= 542111 (max-number [5 11 4 1 2])))
    (is (= 110 (max-number [1 10])))))
