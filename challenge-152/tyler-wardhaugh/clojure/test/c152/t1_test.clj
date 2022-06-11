(ns c152.t1-test
  (:require [clojure.test :refer [deftest is testing]]
            [c152.t1 :refer [min-triangle-sum-path]]))

(deftest examples
  (testing "Examples from the test description"
    (is (= [1 3 2 0 2]
           (min-triangle-sum-path
             [ [1], [5,3], [2,3,4], [7,1,0,2], [6,4,5,2,8] ])))
    (is (= [5 2 1 0 1]
           (min-triangle-sum-path
             [ [5], [2,3], [4,1,5], [0,1,2,3], [7,2,4,1,9] ])))))
