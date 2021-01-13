(ns tw.weekly.c89-test
  (:require [clojure.test :refer [deftest is testing]]
            [tw.weekly.c89.t1 :refer [gcd-sum]]
            [tw.weekly.c89.t2 :refer [magic-matrix]]))

(deftest task-1
  (testing "Task 1, GCD Sum"
    (is (= 3 (gcd-sum 3)))))

(defn transpose [m]
  (apply mapv vector m))

(defn rotate [m]
  (reverse (transpose m)))

(def task-2-possible-answers
  (let [base [[2 7 6]
              [9 5 1]
              [4 3 8]]
        reversed (vec (reverse base))
        transposed (transpose base)
        rev-xposed (vec (reverse transposed))
        unrotated [base reversed transposed rev-xposed]]
    (into (set unrotated) (map (comp vec rotate)) unrotated)))

(deftest task-2
  (testing "Task 2, Magical Matrix"
    (is (some? (task-2-possible-answers (magic-matrix))))))
