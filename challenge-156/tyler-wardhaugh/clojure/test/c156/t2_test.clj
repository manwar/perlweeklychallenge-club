(ns c156.t2-test
  (:require [clojure.test :refer [deftest is testing]]
            [c156.t2 :refer [weird?]]))

(deftest task-2
  (testing "Task 2 produces the correct result"
    (is (false? (weird? 12)))
    (is (true? (weird? 70)))))
