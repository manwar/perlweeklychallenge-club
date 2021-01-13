(ns tw.weekly.c79-test
  (:require [clojure.test :refer [deftest is testing]]
            [tw.weekly.c79.t1 :refer [run]]
            [tw.weekly.c79.t2 :refer [calculate-pools capacity]]))

(deftest task-1
  (testing "Task 1, Count Set Bits"
    (is (= (run 4) 5)
    (is (= (run 3) 4)))))

(deftest task-2
  (testing "Task 2, Trapped Rain Water"
    (is (= (capacity (calculate-pools [2 1 4 1 2 5])) 6))
    (is (= (capacity (calculate-pools [3 1 3 1 1 5])) 6))
    (is (= (capacity (calculate-pools [1 2 3 4 5 4 3 2 1])) 0))
    (is (= (capacity (calculate-pools [4 1 3 1 2 5 10 5 7])) 11))))
