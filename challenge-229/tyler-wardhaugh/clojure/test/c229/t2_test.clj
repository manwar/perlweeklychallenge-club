(ns c229.t2-test
  (:require [clojure.test :refer [deftest is testing]]
            [c229.t2 :refer [two-of-three]]))

(deftest task-1
  (testing "Task 2 produces the correct results from examples in the description"
    (is (= (two-of-three [1 1 2 4] [2 4] [4]) [2 4]))
    (is (= (two-of-three [4 1] [2 4] [1 2]) [1 2 4]))))
