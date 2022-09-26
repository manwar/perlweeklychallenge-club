(ns c184.t1-test
  (:require [clojure.test :refer [deftest is testing]]
            [c184.t1 :refer [add-seq-number]]))

(deftest task-1
  (testing "Task 1 produces the correct results"
    (is (= (add-seq-number ["ab1234" "cd5678" "ef1342"]) ["001234" "015678" "021342"]))
    (is (= (add-seq-number [ "pq1122" "rs3334"]) ["001122" "013334"]))))
