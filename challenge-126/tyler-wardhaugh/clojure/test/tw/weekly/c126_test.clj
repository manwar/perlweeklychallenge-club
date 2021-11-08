(ns tw.weekly.c126-test
  (:require [clojure.test :refer [deftest is testing]]
            [tw.weekly.c126.t1 :refer [count-numbers]]
            [tw.weekly.c126.t2 :as t2]))

(deftest task-1
  (testing "Task 1, Count Numbers"
    (is (= "There are 8 numbers between 1 and 15 that don't contain digit 1.\n2, 3, 4, 5, 6, 7, 8, 9"
           (count-numbers 15)))
    (is (= "There are 13 numbers between 1 and 25 that don't contain digit 1.\n2, 3, 4, 5, 6, 7, 8, 9, 20, 22, 23, 24, 25"
           (count-numbers 25)))))

(deftest task-2
  (testing "Task 2, Minesweeper Game"
    (is (=
         [[\x  1  0  1  \x  2  \x  \x  \x  \x]
          [1   1  0  2  2   4  3   5   5   \x]
          [0   0  1  3  \x  3  \x  2   \x  2]
          [1   1  1  \x \x  4  1   2   2   2]
          [\x  1  1  3  \x  2  0   0   1   \x]]
         (-> t2/DEFAULT-INPUT first t2/parse t2/minesweeper)))))
