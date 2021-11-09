(ns tw.weekly.c138.t2-test
  (:require [clojure.test :refer [deftest is testing]]
            [tw.weekly.c138.t2 :refer [sum-of-splits?]]))

(deftest examples
  (testing "Examples from description"
    (is (true? (sum-of-splits? 81)))
    (is (true? (sum-of-splits? 9801)))
    (is (false? (sum-of-splits? 36)))))
