(ns tw.weekly.c73-test
  (:require [clojure.test :refer [are deftest is testing with-test]]
            [tw.weekly.ch-1 :refer [sliding-min]]
            [tw.weekly.ch-2 :refer []]))

(deftest ch-1
  (testing "Task 1"
    (are [size input output] (= (sequence (sliding-min size) input) output)
         3 [1 5 0 2 9 3 7 6 4 8] (list 0 0 0 2 3 3 4 4)
         )))

(deftest ch-2
  (testing "Task 2"
    ))
