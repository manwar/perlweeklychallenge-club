(ns tw.weekly.c105-test
  (:require [clojure.test :refer [deftest is testing]]
            [clojure.java.io :as io]
            [tw.weekly.c105.t1 :refer [nth-root nth-roots-complex]]
            [tw.weekly.c105.t2 :refer [name-game]])
  (:import [org.apache.commons.math3.complex Complex]
           [org.apache.commons.math3.util Precision]))

(deftest task-1
  (testing "Task 1, Nth root"
    (is (Precision/equals 12.0 (nth-root 5 248832)))
    (is (= [5 true] ((juxt count
                           (partial some #(Complex/equals % (Complex. 12.0 0.0))))
                     (nth-roots-complex 5 248832))))
    (is (Precision/equals (nth-root 5 34) 2.024397458499885))
    (is (= [5 true] ((juxt count
                           (partial some #(Complex/equals
                                            %
                                            (Complex. 2.024397458499885 0.0))))
                     (nth-roots-complex 5 34))))))

(deftest task-2
  (testing "Task 2, The Name Game"
    (is (= (name-game "Katie") (-> "t2.test.katie.txt" io/resource slurp)))
    (is (= (name-game "Billy") (-> "t2.test.billy.txt" io/resource slurp)))))
