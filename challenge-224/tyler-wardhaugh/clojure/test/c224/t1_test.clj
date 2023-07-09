(ns c224.t1-test
  (:require [clojure.test :refer [deftest is testing]]
            [c224.t1 :refer [special-notes?]]))

(deftest task-1
  (testing "Task 1 produces the correct results from examples in the description"
    (is (false? (special-notes? "abc" "xyz")))
    (is (true? (special-notes? "scriptinglanguage" "perl")))
    (is (true? (special-notes? "aabbcc" "abc")))))
