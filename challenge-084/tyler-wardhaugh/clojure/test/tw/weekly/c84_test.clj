(ns tw.weekly.c84-test
  (:require [clojure.test :refer [deftest is testing]]
            [clojure.java.io :as io]
            [tw.weekly.c84.t2 :refer [find-squares parse-matrix-file]]
            [tw.weekly.c84.t1 :refer [reverse-int]]))

(deftest task-1
  (testing "Task 1, Reverse Integer"
    (is (= (reverse-int 1234) 4321))
    (is (= (reverse-int -1234) -4321))
    (is (zero? (reverse-int 1231230512)))))

(deftest task-2
  (let [f (fn [mf] (find-squares (parse-matrix-file (io/resource mf))))]
    (testing "Task 2, Find Square"
      (is (= (count (f "matrix-1")) 1))
      (is (= (count (f "matrix-2")) 4))
      (is (= (count (f "matrix-3")) 0)))))
