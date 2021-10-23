(ns tw.weekly.c135.t1-test
  (:require [clojure.test :refer [deftest is testing]]
            [tw.weekly.c135.t1 :refer [middle-3]]))

(deftest examples
  (testing "Examples from description"
    (is (= "345" (middle-3 1234567)))
    (is (= "123" (middle-3 -123)))
    (is (thrown-with-msg? Exception #"too short" (middle-3 1)))
    (is (thrown-with-msg? Exception #"even number of digits" (middle-3 10)))))
