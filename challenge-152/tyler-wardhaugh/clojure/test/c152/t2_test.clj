(ns c152.t2-test
  (:require [clojure.test :refer [deftest is testing]]
            [c152.t2 :refer [total-area]]))

(deftest examples
  (testing "Examples from the test description"
    (is (= 22 (total-area '[(-1,0), (2,2)] '[(0,-1), (4,4)])))
    (is (= 25 (total-area '[(-3,-1), (1,3)] '[(-1,-3), (2,2)])))))
