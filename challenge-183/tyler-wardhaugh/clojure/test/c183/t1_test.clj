(ns c183.t1-test
  (:require [clojure.test :refer [deftest is testing]]
            [c183.t1 :refer [unique-array]]))

(deftest task-1
  (testing "Task 1 produces the correct result"
    (is (= (set '([1,2], [3,4], [5,6]))
           (unique-array '([1,2], [3,4], [5,6], [1,2]))))
    (is (= (set '([9, 1], [3,7], [2,5]))
           (unique-array '([9,1], [3,7], [2,5], [2,5]))))))
