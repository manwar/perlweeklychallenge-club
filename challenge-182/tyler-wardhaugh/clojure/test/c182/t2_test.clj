(ns c182.t2-test
  (:require [clojure.test :refer [deftest is testing]]
            [c182.t2 :refer [common-path DEFAULT-INPUT]]))

(deftest task-2
  (testing "Task 2 produces the correct result"
    (is (= (common-path DEFAULT-INPUT) "/a/b/c/"))))
