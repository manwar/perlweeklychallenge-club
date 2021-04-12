(ns tw.weekly.c107-test
  (:require [clojure.test :refer [deftest is testing]]
            [tw.weekly.c107.t1 :refer [generate-self-descriptives]]
            [tw.weekly.c107.t2 :refer [list-methods]]))

(deftest task-1
  (testing "Task 1, Self-descriptive Numbers"
    (is (= [1210 2020 21200] (generate-self-descriptives 3)))))

(deftest task-2
  (testing "Task 2, List Methods"
    (is (= '#{notify finalize getClass toString equals hashCode
              clone notifyAll wait}
           (list-methods "java.lang.Object")))))
