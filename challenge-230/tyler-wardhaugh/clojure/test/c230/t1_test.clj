(ns c230.t1-test
  (:require [clojure.test :refer [deftest is testing]]
            [c230.t1 :refer [separate-digits]]))

(defn char->int
  [c]
  (Character/digit c 10))

(deftest task-1
  (testing "Task 1 produces the correct results from examples in the description"
    (is (= [1 3 4 5 6] (map char->int (separate-digits [1 34 5 6]))))
    (is (= [1 2 4 5 1 6 0] (map char->int (separate-digits [1 24 51 60]))))))
