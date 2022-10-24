(ns c187.t2-test
  (:require [clojure.test :refer [deftest is testing]]
            [c187.t2 :refer [magical-triplet]]))

(deftest task-2
  (testing "Task 2 produces the correct results"
    (is (= [3 2 2] (magical-triplet '(1, 2, 3, 2))))
    (is (nil? (magical-triplet '(1, 3, 2))))
    (is (nil? (magical-triplet '(1, 1, 2, 3))))
    (is (= [4 3 2] (magical-triplet '(2, 4, 3)))))
  (testing "... with less than 3 elements"
    (is (nil? (magical-triplet [3 2])))
    (is (nil? (magical-triplet [1])))
    (is (nil? (magical-triplet [])))))
