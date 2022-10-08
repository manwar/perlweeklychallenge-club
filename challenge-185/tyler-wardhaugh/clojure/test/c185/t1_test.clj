(ns c185.t1-test
  (:require [clojure.test :refer [deftest is testing]]
            [c185.t1 :refer [convert-mac-address]]))

(deftest task-1
  (testing "Task 1 produces the correct results"
    (is (= (convert-mac-address "1ac2.34f0.b1c2") "1a:c2:34:f0:b1:c2"))
    (is (= (convert-mac-address "abc1.20f1.345a") "ab:c1:20:f1:34:5a"))))
