(ns c146.t2-test
  (:refer-clojure :exclude [ancestors])
  (:require [clojure.test :refer [deftest is testing]]
            [c146.t2 :refer [parent]]))

(def ancestors (juxt parent (comp parent parent)))

(deftest examples
  (testing "Examples from task description"
    (is (= [3/2 1/2] (ancestors 3/5)))
    (is (= [1/3 1/2] (ancestors 4/3)))))
