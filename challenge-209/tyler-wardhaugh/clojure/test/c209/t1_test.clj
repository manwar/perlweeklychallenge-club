(ns c209.t1-test
  (:require [clojure.test :refer [deftest is testing]]
            [c209.t1 :refer [ends-with-a?]]))

(deftest task-1
  (testing "Task 1 produces the correct results from examples in the description"
    (is (true? (ends-with-a? [1 0 0])))
    (is (false? (ends-with-a? [1 1 1 0])))))
