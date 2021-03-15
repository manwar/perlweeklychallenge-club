(ns tw.weekly.c95-test
  (:require [clojure.test :refer [deftest is testing]]
            [tw.weekly.c95.t1 :refer [palindrome-number?]]))

(deftest task-1
  (testing "Task 1, Palindrome Numbers"
   (is (true? (palindrome-number? 1221)))
   (is (false? (palindrome-number? -101)))
   (is (false? (palindrome-number? 90)))
   (is (true? (palindrome-number? 12321)))))
