(ns tw.weekly.c97-test
  (:require [clojure.test :refer [deftest is testing]]
            [tw.weekly.c97.t1 :refer [caesar]]
            [tw.weekly.c97.t2 :refer [binary-substrings]]))

(deftest task-1
  (testing "Task 1, Caesar Cipher"
    (is (= "QEB NRFZH YOLTK CLU GRJMP LSBO QEB IXWV ALD"
           (caesar "THE QUICK BROWN FOX JUMPS OVER THE LAZY DOG" 3)))))

(deftest task-2
  (testing "Task 2, Binary Substrings"
    (is (= 1 (binary-substrings "101100101" 3)))
    (is (= 2 (binary-substrings "10110111" 4)))))
