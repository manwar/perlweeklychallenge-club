(ns c217.t1-test
  (:require [clojure.test :refer [deftest is testing]]
            [c217.t1 :refer [third-smallest-of-sorted-matrix]]))

(deftest task-1
  (testing "Task 1 produces the correct results from examples in the description"
    (is (= 1 (third-smallest-of-sorted-matrix [[3 1 2] [5 2 4] [0 1 3]])))
    (is (= 4 (third-smallest-of-sorted-matrix [[2 1] [4 5]])))
    (is (= 0 (third-smallest-of-sorted-matrix [[1 0 3] [0 0 0] [1 2 1]])))))
