(ns c193.t1-test
  (:require [clojure.test :refer [deftest is testing]]
            [c193.t1 :refer [binary-string]]))

(deftest task-1
  (testing "Task 1 produces the correct results (description)"
    (is (= ["00" "01" "10" "11"] (binary-string 2)))
    (is (= ["000" "001" "010" "011" "100" "101" "110" "111"]
           (binary-string 3)))))
