(ns c230.t2-test
  (:require [clojure.test :refer [deftest is testing]]
            [c230.t2 :refer [count-words]]))

(deftest task-1
  (testing "Task 2 produces the correct results from examples in the description"
    (is (= 2 (count-words "at" ["pay" "attention" "practice" "attend"])))
    (is (= 3 (count-words "ja" ["janet" "julia" "java" "javascript"])))))
