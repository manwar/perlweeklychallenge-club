(ns tw.weekly.c128-test
  (:require [clojure.test :refer [deftest is testing]]
            [clojure.java.io :as io]
            [tw.weekly.c128.t1 :as t1]
            [tw.weekly.c128.t2 :refer [find-minimum-platforms]]))

(defn solve-t1
  [f]
  (-> f io/resource t1/parse t1/find-max-submatrix))

(deftest task-1
  (testing "Task 1, Maximum Sub-Matrix"
    (is (= [2 3] (solve-t1 "matrix1.txt")))
    (is (= [3 2] (solve-t1 "matrix2.txt")))))

(deftest task-2
  (testing "Task 2, Minimum Platforms"
    (is (= 1 (find-minimum-platforms ["11:20" "14:30"] ["11:50" "15:00"])))
    (is (= 3 (find-minimum-platforms
              ["10:20" "11:00" "11:10" "12:20" "16:20" "19:00"]
              ["10:30" "13:20" "12:40" "12:50" "20:20" "21:20"])))))
