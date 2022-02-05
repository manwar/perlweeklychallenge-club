(ns c150.t1-test
  (:require [clojure.test :refer [deftest is testing]]
            [c150.t1 :refer [DEFAULT-INPUT fibo-words solve]]))

(deftest examples
  (testing "Examples from the test description"
    (is (= \7 (solve (apply fibo-words DEFAULT-INPUT))))))
