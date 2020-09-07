(ns tw.weekly.c76-test
  (:require [clojure.test :refer :all]
            [clojure.java.io :as io]
            [tw.weekly.ch-1 :refer [find-min-primes-to-sum find-min-primes-to-sum-brute-force]]
            [tw.weekly.ch-2 :refer [parse-dict-file parse-grid-file word-search]]))

(deftest ch-1
  (testing "Task 1"
    (let [n-and-results [[6 2] [9 2] [11 1] [12 2] [51 3]]
          fns (juxt second (comp count find-min-primes-to-sum first) (comp count find-min-primes-to-sum-brute-force first))
          results (->> n-and-results
                       (map fns)
                       (map #(is (apply = %))))]
      (dorun results))))

(deftest ch-2
  (testing "Task 2"
    (let [grid (parse-grid-file (io/resource "grid.txt"))
          dict (parse-dict-file (io/resource "dict.txt"))
          words (word-search grid dict)]
      (is (= (into #{} dict) (into #{} words))))))
