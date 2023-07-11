(ns c224.t2-test
  (:require [clojure.test :refer [deftest is testing]]
            [c224.t2 :refer [additive-number?]]))

(deftest task-1
  (testing "Task 2 produces the correct results from examples in the description"
    (is (true? (additive-number? "112358")))
    (is (false? (additive-number? "12345")))
    (is (true? (additive-number? "199100199")))))
