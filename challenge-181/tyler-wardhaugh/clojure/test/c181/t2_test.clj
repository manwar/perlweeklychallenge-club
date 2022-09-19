(ns c181.t2-test
  (:require [clojure.test :refer [deftest is testing]]
            [c181.t2 :refer [hot-day INPUT]]))

(deftest task-2
  (testing "Task 2 produces the correct result"
    (is (= (hot-day INPUT)
           ["2022-08-02" "2022-08-05" "2022-08-06" "2022-08-08"
            "2022-08-10"]))))
