(ns tw.weekly.c133.t1-test
  (:require [clojure.test :refer [deftest is testing]]
            [tw.weekly.c133.t1 :refer [isqrt isqrt-easy]]))

(deftest examples
  (testing "Examples from description"
    (let [both (juxt isqrt isqrt-easy)]
      (is (apply = 3 (both 10)))
      (is (apply = 5 (both 27)))
      (is (apply = 9 (both 85)))
      (is (apply = 10 (both 101))))))
