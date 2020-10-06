(ns tw.weekly.c81-test
  (:require [clojure.test :refer [deftest is testing]]
            [tw.weekly.c81.t1 :refer [common-base-string]]))

(deftest task-1
  (testing "Task 1, Common Base String"
    (is (= (common-base-string "abcdabcd" "abcdabcdabcdabcd") ["abcd" "abcdabcd"]))
    (is (= (common-base-string "aaa" "aa") ["a"]))))
