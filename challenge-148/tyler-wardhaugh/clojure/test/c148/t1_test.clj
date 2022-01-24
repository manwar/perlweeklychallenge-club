(ns c148.t1-test
  (:require [clojure.test :refer [deftest is testing]]
            [c148.t1 :refer [eban? TARGET]]))

(def EBAN-UPTO-100
  "Eban Numbers up to 100 (source: https://oeis.org/A006933)"
  [2, 4, 6, 30, 32, 34, 36, 40, 42, 44, 46, 50, 52, 54, 56, 60, 62, 64, 66])

(deftest target
  (testing "Target identified in task description"
    (is (= EBAN-UPTO-100 (filter eban? (range (inc TARGET))) ))))
