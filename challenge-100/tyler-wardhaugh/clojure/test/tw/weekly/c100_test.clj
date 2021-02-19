(ns tw.weekly.c100-test
  (:require [clojure.test :refer [deftest is testing]]
            [tw.weekly.c100.t1 :refer [fun-time]]
            [tw.weekly.c100.t2 :refer [min-triangle-sum]]))

(deftest task-1
  (testing "Task 1, Fun Time"
    (is (= "17:15" (fun-time "05:15 pm")))
    (is (= "17:15" (fun-time "05:15pm")))
    (is (= "07:15PM" (fun-time "19:15")))))

(deftest task-2
  (testing "Task 2, Triangle Sum"
    (is (= 8 (min-triangle-sum [ [1], [2,4], [6,4,9], [5,1,7,2] ])))
    (is (= 7 (min-triangle-sum [ [3], [3,1], [5,2,3], [4,3,1,3] ])))))
