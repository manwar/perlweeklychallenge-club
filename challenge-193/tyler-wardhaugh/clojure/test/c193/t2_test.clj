(ns c193.t2-test
  (:require [clojure.test :refer [deftest is testing]]
            [c193.t2 :refer [odd-string]]))

(deftest task-2
  (testing "Task 2 produces the correct results"
    (is (= "abc" (odd-string ["adc" "wzy" "abc"])))
    (is (= "bob" (odd-string ["aaa" "bob" "ccc" "ddd"])))))
