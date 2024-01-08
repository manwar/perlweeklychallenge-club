(ns c250.t2-test
  (:require [clojure.test :refer [deftest is testing]]
            [c250.t2 :refer [alphanumeric-string]]))

(deftest task-1
  (testing "Task 2 produces the correct results from examples in the description"
    (is (= 6 (alphanumeric-string ["perl" "2" "000" "python" "r4ku"])))
    (is (= 1 (alphanumeric-string ["001"  "1"  "000"  "0001"])))))
