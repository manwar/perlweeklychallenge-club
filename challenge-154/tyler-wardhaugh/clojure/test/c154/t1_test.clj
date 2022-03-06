(ns c154.t1-test
  (:require [clojure.test :refer [deftest is testing]]
            [c154.t1 :as t1]))

(deftest task-1
  (testing "Task 1 produces the correct result"
    (is (= #{"LERP"} (t1/find-missing t1/GIVEN-BASE t1/GIVEN-PERMS)))))
