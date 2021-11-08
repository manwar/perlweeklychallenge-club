(ns tw.weekly.c127-test
  (:require [clojure.test :refer [deftest is testing]]
            [tw.weekly.c127.t1 :refer [disjoint?]]
            [tw.weekly.c127.t2 :refer [conflict-intervals]]))

(deftest task-1
  (testing "Disjoint Sets"
    (is (false? (disjoint? '(1, 2, 5, 3, 4) '(4, 6, 7, 8, 9))))
    (is (true? (disjoint? '(1, 3, 5, 7, 9) '(0, 2, 4, 6, 8))))))

(deftest task-2
  (testing "Task 2, Conflict Intervals"
    (is (= (conflict-intervals '[ (1,4), (3,5), (6,8), (12, 13), (3,20) ])
           '[ (3,5), (3,20) ]))
    (is (= (conflict-intervals '[ (3,4), (5,7), (6,9), (10, 12), (13,15) ])
           '[ (6,9) ]))))
