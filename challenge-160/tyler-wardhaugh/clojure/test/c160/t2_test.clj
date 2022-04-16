(ns c160.t2-test
  (:require [clojure.test :refer [deftest is testing]]
            [c160.t2 :refer [equilibrium-index]]))

(deftest task-2
  (testing "Task 2 produces the correct result"
    (is (= 3 (equilibrium-index [1 3 5 7 9])))
    (is (= -1 (equilibrium-index [1 2 3 4 5])))
    (is (= 1 (equilibrium-index [2 4 2])))))
