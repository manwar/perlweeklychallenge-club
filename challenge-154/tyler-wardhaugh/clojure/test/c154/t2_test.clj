(ns c154.t2-test
  (:require [clojure.test :refer [deftest is testing]]
            [c154.t2 :refer [first-ten-distinct-padovan-primes]]))

; Expected Output from task description
(def PADOVAN-PRIMES [2 3 5 7 37 151 3329 23833 13091204281 3093215881333057])

(deftest task-2
  (testing "Task 2 produces the correct result"
    (is (= first-ten-distinct-padovan-primes PADOVAN-PRIMES))))
