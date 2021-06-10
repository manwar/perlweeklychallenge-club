(ns tw.weekly.c116-test
  (:require [clojure.test :refer [deftest is testing]]
            [tw.weekly.c116.t1 :refer [number-sequence]]
            #_[tw.weekly.c116.t2 :refer []]))

(deftest task-1
  (testing "Task 1, Number Sequence"
    (is (= "1,2,3,4" (number-sequence 1234)))
    (is (= "9,10,11" (number-sequence 91011)))
    (is (= "10203 as it is impossible to split satisfying the conditions."
           (number-sequence 10203)))))

#_(deftest task-2
  (testing "Task 2, Sum of Squares"
    (is )
    (is )
    (is )))
