(ns tw.weekly.c84-test
  (:require [clojure.test :refer [deftest is testing]]
            [tw.weekly.c84.t1 :refer [reverse-int]]))

(deftest task-1
  (testing "Task 1, Reverse Integer"
    (is (= (reverse-int 1234) 4321))
    (is (= (reverse-int -1234) -4321))
    (is (zero? (reverse-int 1231230512)))))
