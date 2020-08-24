(ns tw.weekly.c74-test
  (:require [clojure.test :refer :all]
            [tw.weekly.ch-1 :refer [majority]]
            [tw.weekly.ch-2 :refer [find-fnr-over-string]]))

(deftest ch-1
  (testing "Task 1"
    (is (= 2 (majority (list 1, 2, 2, 3, 2, 4, 2))))
    (is (= -1 (majority (list 1, 3, 1, 2, 4, 5))))))

(deftest ch-2
  (testing "Task 2"
    (is (= "abb#c" (find-fnr-over-string "ababc")))
    (is (= "xyzyx#" (find-fnr-over-string "xyzzyx")))))
