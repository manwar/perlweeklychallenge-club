(ns tw.weekly.c98-test
  (:require [clojure.test :refer [deftest is testing]]
            [tw.weekly.c98.t1 :refer [readN] :as t1]
            [tw.weekly.c98.t2 :refer [search-insert-position]]))

(deftest task-1
  (testing "Task 1, Caesar Cipher"
    (t1/add-shutdown-hook!)
    (is (= "1234" (apply readN t1/DEFAULT-INPUT)))
    (is (= "5678" (apply readN t1/DEFAULT-INPUT)))
    (is (= "90" (apply readN t1/DEFAULT-INPUT)))))

(deftest task-2
  (testing "Task 2, Search Insert Position"
    (is (= 2 (search-insert-position [1 2 3 4] 3)))
    (is (= 3 (search-insert-position [1 3 5 7] 6)))
    (is (zero? (search-insert-position [12 14 16 18] 10)))
    (is (= 4 (search-insert-position [11 13 15 17] 19)))))
