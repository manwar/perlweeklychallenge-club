(ns c147.t2-test
  (:require [clojure.test :refer [deftest is testing]]
            [c147.t2 :refer [find-suitable-pair]]))

(deftest target
  (testing "Target identified in task description"
    (is (= [1560090 7042750] (find-suitable-pair)))))
