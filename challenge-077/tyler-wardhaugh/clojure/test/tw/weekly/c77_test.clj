(ns tw.weekly.c77-test
  (:require [clojure.test :refer :all]
            [clojure.java.io :as io]
            [tw.weekly.ch-1 :refer [fibo-sum]]
            [tw.weekly.ch-2 :refer []]))

(deftest ch-1
  (testing "Task 1"
    (is (= #{(list 1N 2N 3N) (list 1N 5N)} (into #{} (fibo-sum 6))))
    (is (= #{(list 1N 3N 5N) (list 1N 8N)} (into #{} (fibo-sum 9))))))

(deftest ch-2
  (testing "Task 2"
    ))
