(ns tw.weekly.c136.t1-test
  (:require [clojure.test :refer [deftest is testing]]
            [tw.weekly.c136.t1 :refer [two-friendly?]]))

(deftest examples
  (testing "Examples from description"
    (is (true? (two-friendly? 8 24)))
    (is (false? (two-friendly? 26 39)))
    (is (true? (two-friendly? 4 10)))))
