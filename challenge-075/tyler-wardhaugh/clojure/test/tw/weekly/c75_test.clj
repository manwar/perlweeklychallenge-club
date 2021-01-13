(ns tw.weekly.c75-test
  (:require [clojure.test :refer :all]
            [multiset.core :as ms]
            [tw.weekly.ch-1 :refer [find-coin-sum]]
            [tw.weekly.ch-2 :refer [largest-rectangle-histogram]]))

(deftest ch-1
  (testing "Task 1"
    (let [expected (map (partial into (ms/multiset)) (list [1 1 1 1 1 1] [2 1 1 1 1] [2 2 1 1] [2 2 2] [4 1 1] [4 2]))]
      (is (= (find-coin-sum 6 [1 2 4]) expected)))))

(deftest ch-2
  (testing "Task 2"
    (is (= 12 (largest-rectangle-histogram [2 1 4 5 3 7])))
    (is (= 15 (largest-rectangle-histogram [3 2 3 5 7 5])))))
