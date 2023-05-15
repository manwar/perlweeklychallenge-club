(ns c216.t1-test
  (:require [clojure.test :refer [deftest is testing]]
            [c216.t1 :refer [registration-number]]))

(deftest task-1
  (testing "Task 1 produces the correct results from examples in the description"
    (is (= ["abcd"]
           (registration-number "AB1 2CD" ["abc" "abcd" "bcd"])))
    (is (= ["job" "bjorg"]
           (registration-number "007 JB" ["job" "james" "bjorg"])))
    (is (= ["crack" "rac"]
           (registration-number "C7 RA2" ["crack" "road" "rac"])))))
