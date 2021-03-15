(ns tw.weekly.c101-test
  (:require [clojure.test :refer [deftest is testing]]
            [tw.weekly.c101.t1 :refer [pack-spiral]]
            [tw.weekly.c101.t2 :refer [contains-origin]]))

(deftest task-1
  (testing "Task 1, Pack a Spiral"
    (is (= [[4 3] [1 2]] (pack-spiral [1 2 3 4])))
    (is (= [[5 4] [6 3] [1 2]] (pack-spiral (range 1 7))))
    (is (= [[8 7 6] [9 12 5] [10 11 4] [1 2 3]] (pack-spiral (range 1 13))))))

(deftest task-2
  (testing "Task 2, Origin-containing Triangle"
    (is (false? (apply contains-origin [[0 1] [1 0] [2 2]])))
    (is (true? (apply contains-origin [[1 1] [-1 1] [0 -3]])))
    (is (true? (apply contains-origin [[0 1] [2 0] [-6 0]])))))
