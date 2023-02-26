(ns c205.t2-test
  (:require [clojure.test :refer [deftest is testing]]
            [c205.t2 :refer [max-xor]]))

(deftest task-2
  (testing "Task 2 produces the correct results from examples in the description"
    (is (= 7 (max-xor [1 2 3 4 5 6 7])))
    (is (= 15 (max-xor [10 5 7 12 8])))))
