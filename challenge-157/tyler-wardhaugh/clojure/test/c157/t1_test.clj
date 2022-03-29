(ns c157.t1-test
  (:require [clojure.test :refer [deftest is testing]]
            [clojure.pprint :refer [cl-format]]
            [c157.t1 :refer [pythagorean-means]]))

(def calc (comp (partial map #(cl-format nil "~,1f" %)) pythagorean-means))

(deftest task-1
  (testing "Task 1 produces the correct result"
    (is (= ["4.8" "3.8" "2.8"] (calc [1,3,5,6,9])))
    (is (= ["6.0" "5.2" "4.4"] (calc [2,4,6,8,10])))
    (is (= ["3.0" "2.6" "2.2"] (calc [1,2,3,4,5])))))
