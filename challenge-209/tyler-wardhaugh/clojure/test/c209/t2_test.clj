(ns c209.t2-test
  (:require [clojure.test :refer [deftest is testing]]
            [c209.t2 :refer [merge-accounts]]))

(deftest task-2
  (testing "Task 2 produces the correct results from examples in the description"
    (is (= (merge-accounts [["A" "a1@a.com" "a2@a.com"]
                            ["B" "b1@b.com"]
                            ["A" "a3@a.com" "a1@a.com"]])
           [["A" "a1@a.com" "a2@a.com" "a3@a.com"]
            ["B" "b1@b.com"]]))
    (is (= (merge-accounts [["A" "a1@a.com" "a2@a.com"]
                            ["B" "b1@b.com"]
                            ["A" "a3@a.com"]
                            ["B" "b2@b.com" "b1@b.com"]])
           [["A" "a1@a.com" "a2@a.com"]
            ["A" "a3@a.com"]
            ["B" "b1@b.com" "b2@b.com"]]))))
