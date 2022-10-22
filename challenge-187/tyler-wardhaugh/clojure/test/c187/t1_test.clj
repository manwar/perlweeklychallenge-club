(ns c187.t1-test
  (:require [clojure.test :refer [deftest is testing]]
            [c187.t1 :refer [overlap]]))

(deftest task-1
  (testing "Task 1 produces the correct results"
    (is (= 4 (overlap [{:name "Foo" :SD "12-01" :ED "20-01"}
                       {:name "Bar" :SD "15-01" :ED "18-01"}])))
    (is (= 0 (overlap [{:name "Foo" :SD "02-03" :ED "12-03"}
                       {:name "Bar" :SD "13-03" :ED "14-03"}])))
    (is (= 2 (overlap [{:name "Foo" :SD "02-03" :ED "12-03"}
                       {:name "Bar" :SD "11-03" :ED "15-03"}])))
    (is (= 4 (overlap [{:name "Foo" :SD "30-03" :ED "05-04"}
                       {:name "Bar" :SD "28-03" :ED "02-04"}])))))
