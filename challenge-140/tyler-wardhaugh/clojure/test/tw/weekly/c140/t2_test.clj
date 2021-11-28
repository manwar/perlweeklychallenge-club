(ns tw.weekly.c140.t2-test
  (:require [clojure.test :refer [deftest is testing]]
            [tw.weekly.c140.t2 :refer [get-kth-in-multi]]))

(deftest examples
  (testing "Examples from description"
    (is (= 3 (get-kth-in-multi 2 3 4)))
    (is (= 4 (get-kth-in-multi 3 3 6)))))
