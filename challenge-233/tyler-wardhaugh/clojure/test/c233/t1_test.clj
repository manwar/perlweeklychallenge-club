(ns c233.t1-test
  (:require [clojure.test :refer [deftest is testing]]
            [c233.t1 :refer [similar-words]]))

(deftest task-1
  (testing "Task 1 produces the correct results from examples in the description"
    (is (= 2 (similar-words '("aba", "aabb", "abcd", "bac", "aabc"))))
    (is (= 3 (similar-words '("aabb", "ab", "ba"))))
    (is (= 0 (similar-words '("nba", "cba", "dba"))))))
