(ns c231.t1-test
  (:require [clojure.test :refer [deftest is testing]]
            [c231.t1 :refer [exclude-extrema]]))

(deftest task-1
  (testing "Task 1 produces the correct results from examples in the description"
    (is (= [2 3] (exclude-extrema [3 2 1 4])))
    (is (= -1 (exclude-extrema [3 1])))
    (is (= [2] (exclude-extrema [2 1 3])))))
