(ns c189.t1-test
  (:require [clojure.test :refer [deftest is testing]]
            [c189.t1 :refer [greater-char]]))

(deftest task-1
  (testing "Task 1 produces the correct results"
  (is (= \e (greater-char "emug" \b)))
  (is (= \c (greater-char "dcef" \a)))
  (is (= \r (greater-char "jar" \o)))
  (is (= \c (greater-char "dcaf" \a)))
  (is (= \v (greater-char "tgal" \v)))))
