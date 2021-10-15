(ns tw.weekly.c134.t2-test
  (:require [clojure.test :refer [deftest is testing]]
            [tw.weekly.c134.t2 :refer [gen-mult-table]]))

(deftest examples
  (testing "Examples from description"
    (is (= ['((1 2 3) (2 4 6) (3 6 9))
            #{1 4 6 3 2 9}]
           (gen-mult-table 3 3)))
    (is (= ['((1 2 3 4 5) (2 4 6 8 10) (3 6 9 12 15))
            #{1 4 15 6 3 12 2 9 5 10 8}]
           (gen-mult-table 3 5)))))
