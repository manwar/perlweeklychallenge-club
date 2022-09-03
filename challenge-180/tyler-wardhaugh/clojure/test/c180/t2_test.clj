(ns c180.t2-test
  (:require [clojure.test :refer [deftest is testing]]
            [c180.t2 :refer [trim-list]]))

(deftest task-2
  (testing "Task 2 produces the correct result"
    (is (= '(4,5) (trim-list '(1,4,2,3,5) 3)))
    (is (= '(9,6,8,5) (trim-list '(9,0,6,2,3,8,5) 4)))))
