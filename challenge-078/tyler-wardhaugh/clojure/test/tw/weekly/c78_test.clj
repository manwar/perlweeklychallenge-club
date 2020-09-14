(ns tw.weekly.c78-test
  (:require [clojure.test :refer :all]
            [tw.weekly.c78.t1 :refer [leader-elements]]))

(deftest task-1
  (testing "Task 1, Leader Elements"
    (is (= (leader-elements [9, 10, 7, 5, 6, 1]) (list 10 7 6 1))
    (is (= (leader-elements [3 4 5]) (list 5))))))
