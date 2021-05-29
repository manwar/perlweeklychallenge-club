(ns tw.weekly.c114-test
  (:require [clojure.test :refer [deftest is testing]]
            [tw.weekly.c114.t1 :refer [next-palindrome]]
            [tw.weekly.c114.t2 :refer [higher-int-set-bits]]))

(deftest task-1
  (testing "Task 1, Next Palindrome Number"
    (is (= 1331 (next-palindrome 1234)))
    (is (= 1001 (next-palindrome 999)))))

(deftest task-2
  (testing "Task 2, Higher Integer Set Bits"
    (is (= 5 (higher-int-set-bits 3)))
    (is (= 17 (higher-int-set-bits 12)))))
