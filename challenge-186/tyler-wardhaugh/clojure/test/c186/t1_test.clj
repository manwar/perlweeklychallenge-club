(ns c186.t1-test
  (:require [clojure.test :refer [deftest is testing]]
            [c186.t1 :refer [zip zip']]))

(deftest task-1
  (testing "Task 1 produces the correct results"
    (let [A [1 2 3]
          B ["a" "b" "c"]]
      (is (= [1 "a" 2 "b" 3 "c"] (zip A B) (zip' A B)))
      (is (= ["a" 1 "b" 2 "c" 3] (zip B A) (zip' B A))))))
