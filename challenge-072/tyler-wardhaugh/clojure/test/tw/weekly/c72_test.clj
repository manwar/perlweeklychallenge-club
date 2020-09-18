(ns tw.weekly.c72-test
  (:require [clojure.test :refer [are deftest is testing]]
            [tw.weekly.c72.t1 :refer [fact trailing-zeros]]
            [tw.weekly.c72.t2 :refer []]))

(deftest task-1
  (testing "Task 1, Trailing Zeroes"
    (are [n e] (= (trailing-zeros (fact n)) e)
         10 2
         7 1
         4 0)))

(deftest task-2
  (testing "Task 2, Lines Range"
    ))
