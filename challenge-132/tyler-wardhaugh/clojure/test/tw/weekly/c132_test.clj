(ns tw.weekly.c132-test
  (:require [clojure.test :refer [deftest is testing]]
            [tw.weekly.c132.t1 :as t1]
            #_[tw.weekly.c132.t2 :refer []]))

(def today (t1/parse-date t1/DEFAULT-TODAY))

(deftest task-1
  (testing "Task 1, Mirror Dates"
    (let [today (t1/parse-date t1/DEFAULT-TODAY)]
      (is (= (map t1/parse-date ["2021/09/14" "2021/09/26"])
             (t1/mirror-date (t1/parse-date "2021/09/18") today)))
      (is (= (map t1/parse-date ["1929/10/27" "2067/09/05"])
             (t1/mirror-date (t1/parse-date "1975/10/10") today)))
      (is (= (map t1/parse-date ["1912/07/08" "2076/04/30"])
             (t1/mirror-date (t1/parse-date "1967/02/14") today))))))

(deftest task-2
  (testing "Task 2, Hash Join"
    ))
