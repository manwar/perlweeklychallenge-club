(ns tw.weekly.c134.t1-test
  (:require [clojure.test :refer [deftest is testing]]
            [tw.weekly.c134.t1 :refer [pandigitals]]))

(deftest examples
  (testing "Examples from description"
    (is (= ["1023456789"
            "1023456798"
            "1023456879"
            "1023456897"
            "1023456978"]
           (pandigitals 5)))))
