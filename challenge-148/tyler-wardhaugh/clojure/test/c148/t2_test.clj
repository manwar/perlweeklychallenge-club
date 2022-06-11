(ns c148.t2-test
  (:require [clojure.test :refer [deftest is testing]]
            [c148.t2 :refer [cardano-triplets]]))

(def FIRST-FIVE-CARDANO-TRIPLETS 
  [[2 1 5]
   [5 1 52]
   [5 2 13]
   [8 3 21]
   [11 4 29]])

(deftest target
  (testing "Target identified in task description"
    (is (= FIRST-FIVE-CARDANO-TRIPLETS (take 5 cardano-triplets)))))
