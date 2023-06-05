(ns c218.t2-test
  (:require [clojure.test :refer [deftest is testing]]
            [c218.t2 :refer [max-matrix-score]]))

(deftest task-2
  (testing "Task 2 produces the correct results from examples in the description"
    (is (= 39 (max-matrix-score [[0 0 1 1]
                                 [1 0 1 0]
                                 [1 1 0 0]])))))
