(ns tw.weekly.c96-test
  (:require [clojure.test :refer [deftest is testing]]
            [tw.weekly.c96.t1 :refer [reverse-words]]
            [tw.weekly.c96.t2 :refer [edit-distance]]))

(deftest task-1
  (testing "Task 1, Reverse Words"
    (is (= "Challenge Weekly The" (reverse-words "The Weekly Challenge")))
    (is (= "family same the of part are Raku and Perl"
           (reverse-words
             "    Perl and   Raku are  part of the same family  ")))))

(deftest task-2
  (testing "Task 2, Edit Distance"
    (is (= 3 (edit-distance "kitten" "sitting")))
    (is (= 2 (edit-distance "sunday" "monday")))))
