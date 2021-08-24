(ns tw.weekly.c127-test
  (:require [clojure.test :refer [deftest is testing]]
            [tw.weekly.c127.t1 :refer [disjoint?]]
            #_[tw.weekly.c127.t2 :refer []]))

(deftest task-1
  (testing "Disjoint Sets"
    (is (false? (disjoint? '(1, 2, 5, 3, 4) '(4, 6, 7, 8, 9))))
    (is (true? (disjoint? '(1, 3, 5, 7, 9) '(0, 2, 4, 6, 8))))))

(deftest task-2
  (testing "Task 2, Conflict Intervals"
    ))
