(ns c181.t1-test
  (:require [clojure.java.io :as io]
            [clojure.test :refer [deftest is testing]]
            [c181.t1 :refer [sentence-order INPUT]]))

(def OUTPUT (io/resource "output1.txt"))

(deftest task-1
  (testing "Task 1 produces the correct result"
    (is (= (sentence-order (slurp INPUT)) (slurp OUTPUT)))))
