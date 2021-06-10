(ns tw.weekly.c115-test
  (:require [clojure.test :refer [deftest is testing]]
            #_[tw.weekly.c115.t1 :refer []]
            [tw.weekly.c115.t2 :refer [largest-multiple]]))

(deftest task-2
  (testing "Task 2, Largest Multiple"
    (is (= 6210 (largest-multiple [1 0 2 6])))
    (is (= 8412 (largest-multiple [1 4 2 8])))
    (is (= 7614 (largest-multiple [4 1 7 6])))))
