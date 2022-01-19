(ns c146.t1-test
  (:require [clojure.test :refer [deftest is testing]]
            [c146.t1 :as t1]
            [c146.t1b :as t1b]))

(deftest target
  (testing "Target identified in task description"
    (is (= 104743 (t1/nth-prime t1/TARGET) (t1b/nth-prime t1b/TARGET)))))
