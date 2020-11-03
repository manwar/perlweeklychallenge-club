(ns tw.weekly.c85-test
  (:require [clojure.test :refer [deftest is testing]]
            [tw.weekly.c85.t1 :refer [find-triplet-sum]]))

(deftest task-1
  (testing "Task 1, Triplet Sum"
    (is (some? (find-triplet-sum [1.2 0.4 0.1 2.5])))
    (is (nil? (find-triplet-sum [0.2 1.5 0.9 1.1])))
    (is (some? (find-triplet-sum [0.5 1.1 0.3 0.7])))

    (is (nil? (find-triplet-sum [0 0.5 0.5]))) 
    (is (nil? (find-triplet-sum [0.1 0.2 0.3]))) 
    (is (nil? (find-triplet-sum [1.1 0.1])))
    (is (some? (find-triplet-sum (concat [0.9 0.8 0.05] (repeat 100 (rand-int 1000))))))))
