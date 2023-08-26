(ns c231.t2-test
  (:require [clojure.test :refer [deftest is testing]]
            [c231.t2 :refer [senior-citizens]]))

(deftest task-1
  (testing "Task 2 produces the correct results from examples in the description"
    (is (= 2 (senior-citizens ["7868190130M7522" "5303914400F9211" "9273338290F4010"])))
    (is (= 0 (senior-citizens ["1313579440F2036" "2921522980M5644"] )))))
