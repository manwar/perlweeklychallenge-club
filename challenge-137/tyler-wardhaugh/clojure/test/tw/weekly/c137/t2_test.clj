(ns tw.weekly.c137.t2-test
  (:require [clojure.test :refer [deftest is testing]]
            [tw.weekly.c137.t2 :refer [lychrel]]))

(deftest examples
  (testing "Examples from description"
    (is (= 0 (lychrel 56)))
    (is (= 0 (lychrel 57)))
    (is (= 0 (lychrel 59)))))

(deftest maximum
  (testing "Numbers that exceed our ceiling"
    (is (= 1 (lychrel 998)))
    (is (= 1 (lychrel 196)))))
