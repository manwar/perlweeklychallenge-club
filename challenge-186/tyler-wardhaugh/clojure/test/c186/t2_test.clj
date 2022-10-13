(ns c186.t2-test
  (:require [clojure.test :refer [deftest is testing]]
            [c186.t2 :refer [makeover]]))

(deftest task-2
  (testing "Task 2 produces the correct results"
    (is (= "AEIOU" (makeover "ÃÊÍÒÙ")))
    (is (= "aEiOU" (makeover "âÊíÒÙ")))))
