(ns c223.t1-test
  (:require [clojure.test :refer [deftest is testing]]
            [c223.t1 :refer [count-primes]]))

(deftest task-1
  (testing "Task 1 produces the correct results from examples in the description"
    (is (= 4 (count-primes 10)))
    (is (= 0 (count-primes 1)))
    (is (= 8 (count-primes 20)))))
