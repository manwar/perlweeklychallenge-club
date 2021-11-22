(ns tw.weekly.c139.t2-test
  (:require [clojure.test :refer [deftest is testing]]
            [tw.weekly.c139.t2 :refer [long-primes]]))

(deftest examples
  (testing "Examples from description"
    (is (= [7 17 19 23 29] (long-primes)))))
