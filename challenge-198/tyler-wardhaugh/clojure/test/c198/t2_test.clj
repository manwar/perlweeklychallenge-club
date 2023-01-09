(ns c198.t2-test
  (:require [clojure.test :refer [deftest is testing]]
            [c198.t2 :refer [prime-count]]))

(deftest task-2
  (testing "Task 2 produces the correct results from examples in the description"
    (is (= 4 (prime-count 10)))
    (is (= 6 (prime-count 15)))
    (is (= 0 (prime-count 1)))
    (is (= 9 (prime-count 25)))))
