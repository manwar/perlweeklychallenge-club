(ns tw.weekly.c88-test
  (:require [clojure.test :refer [deftest is testing]]
            [clojure.java.io :as io]
            [tw.weekly.c88.t1 :refer [array-of-product]]
            [tw.weekly.c88.t2 :refer [make-matrix spiral-matrix]]))

(deftest task-1
  (testing "Task 1 Array of Product"
    (is (= [24 60 120 30 40] (array-of-product [5 2 1 4 3])))
    (is (= [12 24 6 8] (array-of-product [2 1 4 3])))))

(def task-2-helper
  ^{:doc "Helper function to test Task 2"}
  (comp spiral-matrix make-matrix io/resource))

(deftest task-2
  (testing "Task 2 Spiral Matrix"
    (is (= [1 2 3 6 9 8 7 4 5]
           (task-2-helper "matrix-1")))
    (is (= [1 2 3 4 8 12 16 15 14 13 9 5 6 7 11 10]
           (task-2-helper "matrix-2")))))
