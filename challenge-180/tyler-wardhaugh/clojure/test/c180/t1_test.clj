(ns c180.t1-test
  (:require [clojure.test :refer [deftest is testing]]
            [c180.t1 :refer [first-unique-char]]))

(deftest task-1
  (testing "Task 1 produces the correct result"
    (is (zero? (first-unique-char "Perl Weekly Challenge")))
    (is (= 1 (first-unique-char "Long Live Perl")))))
