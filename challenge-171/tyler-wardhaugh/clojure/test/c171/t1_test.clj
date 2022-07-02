(ns c171.t1-test
  (:require [clojure.test :refer [deftest is testing]]
            [c171.t1 :refer [generate-odd-abundants]]))

(deftest task-1
  (testing "Task 1 produces the correct result"
    (is (= (take 20 generate-odd-abundants)
           [945 1575 2205 2835 3465 4095 4725 5355 5775 5985 6435 6615 6825
            7245 7425 7875 8085 8415 8505 8925]))))
