(ns tw.weekly.c94-test
  (:require [clojure.test :refer [deftest is testing]]
            [tw.weekly.c94.t1 :refer [group-anagrams]]
            [tw.weekly.c94.t2 :refer [flatten-tree]]))

(deftest task-1
  (testing "Task 1, Group Anagrams"
    (is (= #{ #{"bat", "tab"},
              #{"saw", "was"},
              #{"top", "pot", "opt"}}
           (->> (group-anagrams '("opt", "bat", "saw", "tab", "pot", "top", "was"))
                (into #{} (map set)))))
    (is (= [["x"]] (group-anagrams '("x"))))))

(deftest task-2
  (testing "Task 2, Binary Tree to Linked List"
    (is (= [1 2 4 5 6 7 3] (flatten-tree [1 [2 [4] [5 [6] [7]]] [3]])))
    (is (= [1 2 3 4] (flatten-tree [1 [2 [3] [4]]])))
    (is (= [1 2 4 3 5 6] (flatten-tree [1 [2 [4]] [3 [5] [6]]])))))
