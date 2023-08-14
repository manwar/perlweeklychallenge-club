(ns c229.t1-test
  (:require [clojure.test :refer [deftest is testing]]
            [c229.t1 :refer [out-of-lex-order]]))

(deftest task-1
  (testing "Task 1 produces the correct results from examples in the description"
    (is (= 1 (out-of-lex-order ["abc" "bce" "cae"])))
    (is (= 2 (out-of-lex-order ["yxz" "cba" "mon"])))))
