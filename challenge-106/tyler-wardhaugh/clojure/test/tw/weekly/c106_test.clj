(ns tw.weekly.c106-test
  (:require [clojure.test :refer [deftest is testing]]
            [tw.weekly.c106.t1 :refer [maximum-gap]]
            [tw.weekly.c106.t2 :refer [decimal-string]]))

(deftest task-1
  (testing "Task 1, Maximum Gap"
    (is (= 4 (maximum-gap [2, 9, 3, 5])))
    (is (= 5 (maximum-gap [1, 3, 8, 2, 0])))
    (is (= 0 (maximum-gap [5])))))

; additional test cases pulled from other submissions
(deftest task-2
  (testing "Task 2, Decimal String"
   (is (= "0.(3)" (decimal-string 1 3)))
   (is (= "0.5" (decimal-string 1 2)))
   (is (= "0.0(75)" (decimal-string 5 66)))
   (is (= "-3.(142857)" (decimal-string -22 7)))
   (is (= "-0.375" (decimal-string 3 -8)))
   (is (= "-11" (decimal-string -99 9)))
   (is (= "0.(010309278350515463917525773195876288659793814432989690721649484536082474226804123711340206185567)"
          (decimal-string 1 97)))
   (is (= "5.(210084033613445378151260504201680672268907563025)"
          (decimal-string 620 119)))
   (is (= "0.0001(6)" (decimal-string 1 6000)))
   (is (= "0.(0196078431372549)" (decimal-string 1 51)))))
