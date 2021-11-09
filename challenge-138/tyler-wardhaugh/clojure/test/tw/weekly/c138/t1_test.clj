(ns tw.weekly.c138.t1-test
  (:require [clojure.test :refer [deftest is testing]]
            [tw.weekly.c138.t1 :refer [count-workdays]]))

(deftest examples
  (testing "Examples from description"
    (is (= 261 (count-workdays 2021)))
    (is (= 262 (count-workdays 2020)))))
