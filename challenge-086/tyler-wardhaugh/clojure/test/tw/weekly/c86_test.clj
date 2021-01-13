(ns tw.weekly.c86-test
  (:require [clojure.test :refer [deftest is testing]]
            [clojure.java.io :as io]
            [tw.weekly.c86.t1 :refer [pair-difference]]
            [tw.weekly.c86.t2 :refer [parse-sudoku-file solve]]))

(deftest task-1
  (testing "Task 1, Pair Difference"
    (is (some? (pair-difference 7 [10 8 12 15 5])))
    (is (some? (pair-difference 6 [1 5 2 9 7])))
    (is (nil? (pair-difference 15 [10 30 20 50 40])))
    (is (some? (pair-difference 0 [100 1 2 3 4 5 100 999 999])))
    (is (nil? (pair-difference 0 [100 1 2 3 4 5 101])))))

(deftest task-2
  (testing "Task 2, Power of Two Integers"
    (is (some? (solve (parse-sudoku-file (io/resource "sudoku-1")))))
    (is (some? (solve (parse-sudoku-file (io/resource "sudoku-2")))))
    (is (some? (solve (parse-sudoku-file (io/resource "sudoku-3")))))))
