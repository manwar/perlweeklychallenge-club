(ns tw.weekly.c82-test
  (:require [clojure.test :refer [deftest is testing]]
            [tw.weekly.c82.t1 :refer [common-factors]]))

(deftest task-1
  (testing "Task 1, Common Factors"
    (is (= (common-factors 12 18) #{1 2 3 6}))
    (is (= (common-factors 18 23) #{1}))))
