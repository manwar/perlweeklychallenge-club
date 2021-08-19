(ns tw.weekly.c126-test
  (:require [clojure.test :refer [deftest is testing]]
            [tw.weekly.c126.t1 :refer [count-numbers]]
            #_[tw.weekly.c126.t2 :refer []]))

(deftest task-1
  (testing "Task 1, Count Numbers"
    (is (= "There are 8 numbers between 1 and 15 that don't contain digit 1.\n2, 3, 4, 5, 6, 7, 8, 9"
           (count-numbers 15)))
    (is (= "There are 13 numbers between 1 and 25 that don't contain digit 1.\n2, 3, 4, 5, 6, 7, 8, 9, 20, 22, 23, 24, 25"
           (count-numbers 25)))))
