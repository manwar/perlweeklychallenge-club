(ns tw.weekly.c76-test
  (:require [clojure.test :refer :all]
            [clojure.java.io :as io]
            [tw.weekly.ch-1 :refer [find-min-primes-to-sum find-min-primes-to-sum-brute-force]]
            [tw.weekly.ch-2 :refer [parse-dict-file parse-grid-file word-search]]))

(deftest ch-1
  (testing "Task 1"
    (is (= 2 (count (find-min-primes-to-sum 9)) (count (find-min-primes-to-sum-brute-force 9))))
    (is (= 2 (count (find-min-primes-to-sum 34)) (count (find-min-primes-to-sum-brute-force 34))))))

(deftest ch-2
  (testing "Task 2"
    (let [grid (parse-grid-file (io/resource "grid.txt"))
          dict (parse-dict-file (io/resource "dict.txt"))
          words (word-search grid dict)]
      (is (= (into #{} dict) (into #{} words))))))
