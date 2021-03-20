(ns tw.weekly.c104-test
  (:require [clojure.test :refer [deftest is testing]]
            [tw.weekly.c104.t1 :refer [fusc]]))

(deftest task-1
  (testing "Task 1, FUSC Sequence"
    (is (= [0, 1, 1, 2, 1, 3, 2, 3, 1, 4, 3, 5, 2, 5, 3, 4, 1, 5, 4, 7, 3, 8,
            5, 7, 2, 7, 5, 8, 3, 7, 4, 5, 1, 6, 5, 9, 4, 11, 7, 10, 3, 11, 8,
            13, 5, 12, 7, 9, 2, 9]
           (fusc 50)))))
