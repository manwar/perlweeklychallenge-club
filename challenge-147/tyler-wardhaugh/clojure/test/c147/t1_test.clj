(ns c147.t1-test
  (:require [clojure.test :refer [deftest is testing]]
            [c147.t1 :as t1]))

; source: https://oeis.org/A024785
(def FIRST-20-LEFT-TRUNCATABLE-PRIMES
  [2, 3, 5, 7, 13, 17, 23, 37, 43, 47, 53, 67, 73, 83, 97, 113, 137, 167, 173, 197])

(deftest target
  (testing "Target identified in task description"
    (is (= FIRST-20-LEFT-TRUNCATABLE-PRIMES (t1/left-truncatable-primes t1/TARGET)))))
