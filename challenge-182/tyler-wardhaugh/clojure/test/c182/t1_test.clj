(ns c182.t1-test
  (:require [clojure.test :refer [deftest is testing]]
            [c182.t1 :refer [max-index]]))

(deftest task-1
  (testing "Task 1 produces the correct result"
    (is (= (max-index '(5, 2, 9, 1, 7, 6)) 2))
    (is (= (max-index '(4, 2, 3, 1, 5, 0)) 4))))
