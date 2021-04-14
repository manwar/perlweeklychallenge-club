(ns tw.weekly.c108-test
  (:require [clojure.test :refer [deftest is testing]]
            [tw.weekly.c108.t2 :refer [bell-numbers]]))

(deftest task-2
  (testing "Task 2 Bell Numbers"
    (is (= [1 1 2 5 15 52 203 877 4140 21147] (bell-numbers 10)))))
