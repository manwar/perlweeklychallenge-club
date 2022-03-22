(ns c156.t1-test
  (:require [clojure.test :refer [deftest is testing]]
            [c156.t1 :refer [pernicious?]]))

; Expected Output, from https://theweeklychallenge.org/blog/perl-weekly-challenge-156/#TASK1
(def EXPECTED [3, 5, 6, 7, 9, 10, 11, 12, 13, 14])

(deftest task-1
  (testing "Task 1 produces the correct result"
    (is (= EXPECTED (->> (range) (filter pernicious?) (take 10))))))
