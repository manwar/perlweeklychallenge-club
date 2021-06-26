(ns tw.weekly.c118-test
  (:require [clojure.core.matrix :as m]
            [clojure.test :refer [deftest is testing]]
            [tw.weekly.c118.t1 :refer [binary-palindrome]]
            [tw.weekly.c118.t2 :as t2]))

(deftest task-1
  (testing "Task 1, Binary Palindrom"
    (is (true? (binary-palindrome 5)))
    (is (false? (binary-palindrome 4)))))

(deftest task-2
  (testing "Task 2, Adventure of Knight"
    (is (= ["a8" "c7" "e6" "d4" "b3" "c1" "a2" "c3" "b1" "d2" "c4" "b2"]
           (-> t2/DEFAULT-INPUT first t2/parse-matrix m/matrix
               t2/adventure-of-knight)))))
