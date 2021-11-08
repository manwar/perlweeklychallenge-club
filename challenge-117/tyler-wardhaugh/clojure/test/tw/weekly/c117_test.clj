(ns tw.weekly.c117-test
  (:require [clojure.test :refer [deftest is testing]]
            [clojure.java.io :as io]
            [tw.weekly.c117.t1 :as t1]
            [tw.weekly.c117.t2 :refer [find-possible-paths]]))

(deftest task-1
  (testing "Task 1, Missing Row"
    (let [example (first t1/DEFAULT-INPUT)
          m-first (io/resource "input-missing-first.txt")
          m-last (io/resource "input-missing-last.txt")]
      (is (= 12 (t1/missing-row-by-incrementing example)))
      (is (= 12 (t1/missing-row-by-set-difference example)))
      (is (= 1 (t1/missing-row-by-incrementing m-first)))
      (is (= 1 (t1/missing-row-by-set-difference m-first)))
      (is (= 15 (t1/missing-row-by-incrementing m-last)))
      (is (= 15 (t1/missing-row-by-set-difference m-last))))))

(deftest task-2
  (testing "Task 2, Find Possible Paths"
    (is (= #{"LH" "R"} (find-possible-paths 1)))
    (is (= #{"LHLH" "LHR" "LLHH" "LRH" "RLH" "RR"} (find-possible-paths 2)))
    (is (=
          #{"LHLHLH" "LHLHR" "LHLLHH" "LHLRH" "LHRLH" "LHRR" "LLHHLH" "LLHHR"
            "LLHLHH" "LLHRH" "LLLHHH" "LLRHH" "LRHLH" "LRHR" "LRLHH" "LRRH"
            "RLHLH" "RLHR" "RLLHH" "RLRH" "RRLH" "RRR"}
          (find-possible-paths 3)))))
