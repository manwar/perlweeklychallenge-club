(ns c189.t2-test
  (:require [clojure.test :refer [deftest is testing]]
            [c189.t2 :refer [array-degree]]))

(deftest task-2
  (testing "Task 2 produces the correct results"
    (is (= [3 3] (array-degree [1 3 3 2])))
    (is (= [1 2 1] (array-degree [1 2 1 3])))
    (is (= [2 1 2] (array-degree [1 3 2 1 2])))
    (is (= [1 1] (array-degree [1 1 2 3 2])))
    (is (= [1 2 1 1] (array-degree [2 1 2 1 1])))))
