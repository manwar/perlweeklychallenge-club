(ns tw.weekly.c99-test
  (:require [clojure.test :refer [deftest is testing]]
            [tw.weekly.c99.t1 :refer [pattern-match]]
            [tw.weekly.c99.t2 :refer [unique-subsequences]]))

(deftest task-1
  (testing "Task 1, Pattern Match"
    (is (true? (pattern-match "abcde" "a*e")))
    (is (false? (pattern-match "abcde" "a*d")))
    (is (false? (pattern-match "abcde" "?b*d")))
    (is (true? (pattern-match "abcde" "a*c?e")))))

(deftest task-2
  (testing "Task 2, Unique Subsequences"
    (is (= 5 (unique-subsequences "littleit" "lit")))
    (is (= 3 (unique-subsequences "london" "lon")))))
