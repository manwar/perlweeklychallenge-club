(ns tw.weekly.c79-test
  (:require [clojure.test :refer [deftest is testing]]
            [tw.weekly.c79.t2 :refer []]))
            [tw.weekly.c79.t1 :refer [run]]

(deftest task-1
  (testing "Task 1, Count Set Bits"
    (is (= (run 4) 5)
    (is (= (run 3) 4)))))

(deftest task-2
  (testing ""
    ))
