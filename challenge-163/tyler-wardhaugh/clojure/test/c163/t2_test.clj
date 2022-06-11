(ns c163.t2-test
  (:require [clojure.test :refer [deftest is testing]]
            [c163.t2 :refer [summations]]))

(deftest task-2
  (testing "Task 2 produces the correct result"
    (is (= 42 (summations [1 2 3 4 5])))
    (is (= 70 (summations [1 3 5 7 9])))))
