(ns tw.weekly.c136.t2-test
  (:require [clojure.test :refer [deftest is testing]]
            [tw.weekly.c136.t2 :refer [fibo-sum-count]]))

(deftest examples
  (testing "Examples from description"
    (is (= 4 (fibo-sum-count 16)))
    (is (= 2 (fibo-sum-count 9)))
    (is (= 2 (fibo-sum-count 15)))))
