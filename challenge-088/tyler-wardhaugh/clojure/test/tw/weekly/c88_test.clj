(ns tw.weekly.c88-test
  (:require [clojure.test :refer [deftest is testing]]
            [tw.weekly.c88.t1 :refer [array-of-product]]))

(deftest task-1
  (testing "Task 1 Array of Product"
    (is (= [24 60 120 30 40] (array-of-product [5 2 1 4 3])))
    (is (= [12 24 6 8] (array-of-product [2 1 4 3])))))
