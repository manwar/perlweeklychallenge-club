(ns tw.weekly.c139.t1-test
  (:require [clojure.test :refer [deftest is testing]]
            [tw.weekly.c139.t1 :refer [ordered? shortcircuiting-ordered?]]))

(def both (juxt ordered? shortcircuiting-ordered?))

(deftest examples
  (testing "Examples from description"
    (is (every? true? (both [1 2 3 4 5])))
    (is (every? false? (both [1 3 2 4 5])))))

(deftest more
  (testing "More interesting tests"
    (is (every? true? (both [1])))
    (is (every? true? (both [])))))
