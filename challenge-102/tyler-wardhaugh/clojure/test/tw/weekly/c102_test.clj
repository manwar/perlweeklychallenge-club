(ns tw.weekly.c102-test
  (:require [clojure.test :refer [deftest is testing]]
            [tw.weekly.c102.t1 :refer [rare-numbers]]
            [tw.weekly.c102.t2 :refer [hash-counting-str]]))

(deftest task-1
  (testing "Task 1, Rare Numbers"
    (is (= ["65"] (rare-numbers 2)))
    (is (= ["621770"] (rare-numbers 6)))
    (is (= ["281089082"] (rare-numbers 9)))
    (is (= #{"2022652202" "2042832002"} (set (rare-numbers 10))))))

(deftest task-2
  (testing "Task 2, Hash-counting String"
    (is (= "#" (hash-counting-str 1)))
    (is (= "2#" (hash-counting-str 2)))
    (is (= "#3#" (hash-counting-str 3)))
    (is (= "#3#5#7#10#" (hash-counting-str 10)))
    (is (= "2#4#6#8#11#14#" (hash-counting-str 14)))))
