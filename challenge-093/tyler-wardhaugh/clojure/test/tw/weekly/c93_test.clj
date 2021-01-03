(ns tw.weekly.c93-test
  (:require [clojure.test :refer [deftest is testing]]
            [tw.weekly.c93.t1 :refer [max-points]]
            [tw.weekly.c93.t2 :refer [sum-paths]]))

(deftest task-1
  (testing "Task 1, Max Points"
    (is (= 1 (max-points '((1,1)))))
    (is (= 2 (max-points '((1,1), (2,2)))))))
    (is (= 3 (max-points '((1,1), (2,2), (3,3)))))
    (is (= 3 (max-points '((1,1), (2,2), (3,1), (1,3), (5,3)))))

(deftest task-2
  (testing "Task 2, Sum Path"
    (is (= 13 (sum-paths [1 [2 [3] [4]]])))
    (is (= 26 (sum-paths [1 [2 [4]] [3 [5] [6]]])))))
