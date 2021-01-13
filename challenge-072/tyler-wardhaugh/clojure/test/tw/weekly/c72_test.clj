(ns tw.weekly.c72-test
  (:require [clojure.test :refer [are deftest is testing]]
            [clojure.java.io :as io]
            [tw.weekly.c72.t1 :refer [fact trailing-zeros]]
            [tw.weekly.c72.t2 :refer [lines-from]]))

(deftest task-1
  (testing "Task 1, Trailing Zeroes"
    (are [n e] (= (trailing-zeros (fact n)) e)
         10 2
         7 1
         4 0)))

(deftest task-2
  (testing "Task 2, Lines Range"
    (is (= (list "L1" "L2" "L3") (lines-from (io/resource "input.txt") 1 3)))))
