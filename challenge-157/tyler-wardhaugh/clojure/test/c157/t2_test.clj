(ns c157.t2-test
  (:require [clojure.test :refer [deftest is testing]]
            [c157.t2 :refer [brazilian?]]))

(deftest task-2
  (testing "Task 2 produces the correct result"
    (is (true? (brazilian? 7)))
    (is (true? (brazilian? 6)))
    (is (true? (brazilian? 8)))))
