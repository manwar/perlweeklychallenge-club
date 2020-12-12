(ns tw.weekly.c90-test
  (:require [clojure.test :refer [deftest is testing]]
            [tw.weekly.c90.t1 :refer [DEFAULT-DNA process-dna]]
            [tw.weekly.c90.t2 :refer [ethiopian-multiply]]))

(def COMPLEMENT-DEFAULT-DNA
  "CATTTGGGGAAAAGTAAATCTGTCTAGCTGAGGAATAGGTAAGAGTCTCTACACAACGACCAGCGGC")

(deftest task-1
  (testing "Task 1, DNA Sequence"
    (is (= [{\G 13, \T 22, \A 14, \C 18}, COMPLEMENT-DEFAULT-DNA]
           (process-dna DEFAULT-DNA)))))

(deftest task-2
  (testing "Task 2, Ethiopian Multiplication"
    (is (= 168 (ethiopian-multiply 12 14)))))
