(ns c184.t2-test
  (:require [clojure.test :refer [deftest is testing]]
            [c184.t2 :refer [split-array]]))

(deftest task-2
  (testing "Task 2 produces the correct results"
    (is (= (split-array ["a 1 2 b 0" "3 c 4 d"])
           [[[1 2 0]  [3 4]] [["a" "b"] ["c" "d"]]]))
    (is (= (split-array ["1 2"  "p q r"  "s 3"  "4 5 t"])
           [[[1 2]  [3]  [4 5]] [["p" "q" "r"]  ["s"]  ["t"]]]))))
