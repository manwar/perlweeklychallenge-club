(ns tw.weekly.c76-test
  (:require [clojure.test :refer :all]
            [tw.weekly.ch-1 :refer [find-min-primes-to-sum find-min-primes-to-sum-brute-force]]
            [tw.weekly.ch-2 :refer []]))

(deftest ch-1
  (testing "Task 1"
    (is (= 2 (count (find-min-primes-to-sum 9)) (count (find-min-primes-to-sum-brute-force 9))))
    (is (= 2 (count (find-min-primes-to-sum 34)) (count (find-min-primes-to-sum-brute-force 34))))))

(deftest ch-2
  (testing "Task 2"
    ))
