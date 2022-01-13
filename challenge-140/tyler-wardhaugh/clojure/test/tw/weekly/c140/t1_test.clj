(ns tw.weekly.c140.t1-test
  (:require [clojure.test :refer [deftest is testing]]
            [tw.weekly.c140.t1 :refer [add-binary]]))

(deftest examples
  (testing "Examples from description"
    (is (= "100" (add-binary "11" "1")))
    (is (= "110" (add-binary "101" "1")))
    (is (= "111" (add-binary "100" "11")))))
