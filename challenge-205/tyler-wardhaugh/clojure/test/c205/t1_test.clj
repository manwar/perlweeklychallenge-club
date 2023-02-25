(ns c205.t1-test
  (:require [clojure.test :refer [deftest is testing]]
            [c205.t1 :refer [third-highest]]))

(deftest task-1
  (testing "Task 1 produces the correct results from examples in the description"
    (is (= 3 (third-highest [5 3 4])))
    (is (= 6 (third-highest [5 6])))
    (is (= 3 (third-highest [5 4 4 3])))))
