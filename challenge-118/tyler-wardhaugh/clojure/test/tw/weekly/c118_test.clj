(ns tw.weekly.c118-test
  (:require [clojure.test :refer [deftest is testing]]
            [tw.weekly.c118.t1 :refer [binary-palindrome]]
            #_[tw.weekly.c118.t2 :refer []]))

(deftest task-1
  (testing "Task 1, Binary Palindrom"
    (is (true? (binary-palindrome 5)))
    (is (false? (binary-palindrome 4)))))

(deftest task-2
  (testing "Task 2, Adventure of Knight"
    ))
