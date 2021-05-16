(ns tw.weekly.c112-test
  (:require [clojure.test :refer [deftest is testing]]
            [tw.weekly.c112.t1 :refer [canonicalize]]
            [tw.weekly.c112.t2 :refer [climb-stairs]]))

(deftest task-1
  (testing "Task 1, Canonical Path"
    (is (= "/a" (canonicalize "/a/")))
    (is (= "/a/b/c" (canonicalize "/a/b//c/")))
    (is (= "/a" (canonicalize "/a/b/c/../..")))))

(deftest task-2
  (testing "Task 2, Climb Stairs"
    (is (= 3 (climb-stairs 3)))
    (is (= 5 (climb-stairs 4)))))
