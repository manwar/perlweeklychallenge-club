(ns c160.t1-test
  (:require [clojure.test :refer [deftest is testing]]
            [c160.t1 :refer [spell]]))

(deftest task-1
  (testing "Task 1 produces the correct result"
    (is (= "Five is four, four is magic." (spell 5)))
    (is (= "Seven is five, five is four, four is magic." (spell 7)))
    (is (= "Six is three, three is five, five is four, four is magic." (spell 6)))))
