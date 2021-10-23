(ns tw.weekly.c135.t2-test
  (:require [clojure.test :refer [deftest is testing]]
            [tw.weekly.c135.t2 :refer [sedol?]]))

(deftest examples
  (testing "Examples from description"
    (is (true? (sedol? "2936921")))
    (is (false? (sedol? "1234567")))
    (is (true? (sedol? "B0YBKL9")))))
